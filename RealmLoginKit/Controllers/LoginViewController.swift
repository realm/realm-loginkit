//
//  LoginViewController.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit
import TORoundedTableView

enum LoginViewControllerStyle {
    case lightTranslucent
    case lightOpaque
    case darkTranslucent
    case darkOpaque
}

class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    var style = LoginViewControllerStyle.lightTranslucent
    
    var isRegistering: Bool {
        set {
            setRegistering(newValue, animated: false)
        }
        get { return _registering }
    }
    
    //MARK: - Private Properties
    
    /* Assets */
    private let lockIcon = UIImage.lockIcon()
    private let mailIcon = UIImage.mailIcon()
    
    /* Views */
    private let navigationBar = UINavigationBar()
    private let tableView = TORoundedTableView()
    private let headerView = LoginHeaderView()
    private let footerView = LoginFooterView()
    private let copyrightView = UILabel()
    
    private var effectView: UIVisualEffectView?
    private var dimmingView: UIView?
    
    /* State tracking */
    private var _registering: Bool = false
    private var keyboardHeight: CGFloat = 0.0
    
    /* Login/Register Credentials */
    private var email: String?
    private var password: String?
    private var confirmPassword: String?
    
    /* Layout Constants */
    private let copyrightViewMargin: CGFloat = 45
    
    /* State Convienience Methods */
    private var isTranslucent: Bool  {
        return style == .lightTranslucent || style == .darkTranslucent
    }
    
    private var isDarkStyle: Bool {
        return style == .darkTranslucent || style == .darkOpaque
    }
    
    //MARK: - Class Creation
    
    init(style: LoginViewControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        
        modalPresentationStyle = isTranslucent ? .overFullScreen : .fullScreen
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    convenience init() {
        self.init(style: .lightTranslucent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - View Setup
    
    private func setUpTranslucentViews() {
        effectView = UIVisualEffectView()
        effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        effectView?.frame = view.bounds
        effectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(effectView!)
        
        dimmingView = UIView()
        dimmingView?.frame = view.bounds
        dimmingView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(dimmingView!)
    }
    
    private func setUpCommonViews() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.maximumWidth = 500
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.delaysContentTouches = false
        view.addSubview(tableView)
        
        footerView.loginButtonTapped = {
            
        }
        
        footerView.registerButtonTapped = {
            self.setRegistering(!self.isRegistering, animated: true)
        }
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 20)
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.alpha = 0.0
        view.addSubview(navigationBar)
        
        copyrightView.text = "With ❤️ from the Realm team, 2017."
        copyrightView.textAlignment = .center
        copyrightView.font = UIFont.systemFont(ofSize: 15)
        copyrightView.sizeToFit()
        copyrightView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        copyrightView.frame.origin.y = view.bounds.height - copyrightViewMargin
        copyrightView.frame.origin.x = (view.bounds.width - copyrightView.frame.width) * 0.5
        view.addSubview(copyrightView)
    }
    
    func applyTheme() {

        navigationBar.barStyle  = isDarkStyle ? .blackTranslucent : .default
        copyrightView.textColor = isDarkStyle ? UIColor(white: 0.3, alpha: 1.0) : UIColor(white: 0.6, alpha: 1.0)
        
        
        if effectView != nil {
            effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        }
        
        if dimmingView != nil {
            dimmingView?.backgroundColor = isDarkStyle ? UIColor(white: 0.1, alpha: 0.3) : UIColor(white: 0.9, alpha: 0.3)
        }
    }
    
    //MARK: - View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        if isTranslucent {
            setUpTranslucentViews()
        }
        
        setUpCommonViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableContentInset()
    }
    
    func layoutTableContentInset() {
        
        // Vertically align the table view so the table cells are in the middle
        let boundsHeight = view.bounds.size.height - keyboardHeight // Adjusted for keyboard visibility
        let contentHeight = tableView.contentSize.height
        let sectionHeight = tableView.rect(forSection: 0).size.height
        let contentMidPoint: CGFloat //
        
        // If keyboard is not visible, align the table cells to the middle of the screen,
        // else just align the whole content region
        if keyboardHeight > 0 {
            contentMidPoint = contentHeight * 0.5
        }
        else {
            contentMidPoint = headerView.frame.height + (sectionHeight * 0.5)
        }
        
        var topPadding    = max(0, (boundsHeight * 0.5) - contentMidPoint)
        if keyboardHeight > 0 { topPadding += (UIApplication.shared.statusBarFrame.height + 10) }
        
        var bottomPadding:CGFloat = 0.0
        if keyboardHeight > 0 {
            bottomPadding = keyboardHeight + 15
        }
        
        var edgeInsets = tableView.contentInset
        edgeInsets.top = topPadding
        edgeInsets.bottom = bottomPadding
        tableView.contentInset = edgeInsets
    }
    
    //MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if UIApplication.shared.isStatusBarHidden {
            navigationBar.alpha = 0.0
            return
        }
        
        let statusBarFrameHeight = UIApplication.shared.statusBarFrame.height
        navigationBar.frame.size.height = statusBarFrameHeight
        
        // Show the navigation bar when content starts passing under the status bar
        let verticalOffset = scrollView.contentOffset.y
        
        if verticalOffset >= -statusBarFrameHeight {
            navigationBar.alpha = 1.0
        }
        else if verticalOffset <= -(statusBarFrameHeight + 10) {
            navigationBar.alpha = 0.0
        }
        else {
            navigationBar.alpha = 1.0 - ((abs(verticalOffset) - 10) / statusBarFrameHeight)
        }
        
        // Offset the copyright label
        let normalizedOffset = verticalOffset + scrollView.contentInset.top
        copyrightView.frame.origin.y = (view.bounds.height - copyrightViewMargin) - normalizedOffset
    }
    
    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isRegistering ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CapCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = LoginTableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.imageView?.tintColor = UIColor(white: 0.6, alpha: 1.0)
            cell?.selectionStyle = .none
        }
        
        let textFieldCell = (cell as! LoginTableViewCell)
        
        // Configure rounded caps
        textFieldCell.topCornersRounded = (indexPath.row == 0)
        textFieldCell.bottomCornersRounded = (!isRegistering ? indexPath.row == 1 : indexPath.row == 2)
        
        // Configure icons
        textFieldCell.imageView?.image = (indexPath.row == 0 ? mailIcon : lockIcon)
        
        let textField = textFieldCell.textField
        
        // Configure text field
        switch indexPath.row {
        case 0:
            textField.placeholder = "Email Address"
            textField.text = email
            textField.isSecureTextEntry = false
            textField.keyboardType = .emailAddress
            textField.returnKeyType = .next
            textFieldCell.textChangedHandler = { self.email = textFieldCell.textField.text }
            textFieldCell.returnButtonTappedHandler = { self.makeFirstResponder(atRow: 1) }
        case 1:
            textField.placeholder = "Password"
            textField.text = password
            textField.isSecureTextEntry = true
            textField.keyboardType = .default
            textField.returnKeyType = isRegistering ? .next : .done
            textFieldCell.textChangedHandler = { self.password = textFieldCell.textField.text }
            textFieldCell.returnButtonTappedHandler = {
                if self.isRegistering {
                    self.makeFirstResponder(atRow: 1)
                }
                else {
                    // Submit Form
                }
            }
        case 2:
            textField.placeholder = "Confirm Password"
            textField.text = confirmPassword
            textField.isSecureTextEntry = true
            textField.keyboardType = .default
            textField.returnKeyType = .done
            textFieldCell.textChangedHandler = { self.confirmPassword = textFieldCell.textField.text }
            textFieldCell.returnButtonTappedHandler = { self.makeFirstResponder(atRow: 1) }
            textFieldCell.returnButtonTappedHandler = { /* Begin Submission */ }
        default:
            break
        }
        
        return textFieldCell
    }
    
    // MARK: - Login/Register Transition
    
    func setRegistering(_ registering: Bool, animated: Bool) {
        guard _registering != registering else {
            return
        }
        
        _registering = registering
        
        // Insert/Delete the 'confirm password' field
        if _registering {
            tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        }
        else {
            tableView.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        }
        
        // Reload the middle row to refresh its cap graphics
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
        
        // Animate the content size adjustments
        animateContentInsetTransition()
        
        headerView.setRegistering(_registering, animated: animated)
        footerView.setRegistering(_registering, animated: animated)
    }
    
    // MARK: - Keyboard Handling
    func makeFirstResponder(atRow row: Int) {
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! LoginTableViewCell
        cell.textField.becomeFirstResponder()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        keyboardHeight = keyboardFrame.height
        animateContentInsetTransition()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        keyboardHeight = 0
        animateContentInsetTransition()
    }
    
    private func animateContentInsetTransition() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.9, options: [], animations: {
            self.layoutTableContentInset()
        }, completion: nil)
        
        // When animating the table view edge insets when its rounded, the header view
        // snaps because their width override is caught in the animation block.
        tableView.tableHeaderView?.layer.removeAllAnimations()
    }
}
