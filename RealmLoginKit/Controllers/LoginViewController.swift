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

class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    public private(set) var style = LoginViewControllerStyle.lightTranslucent
    
    var isRegistering: Bool {
        set {
            setRegistering(newValue, animated: false)
        }
        get { return _registering }
    }
    
    //MARK: - Private Properties
    
    /* Assets */
    private let earthIcon = UIImage.earthIcon()
    private let lockIcon = UIImage.lockIcon()
    private let mailIcon = UIImage.mailIcon()
    private let tickIcon = UIImage.tickIcon()
    
    /* Views */
    private let containerView = UIView()
    private let navigationBar = UINavigationBar()
    private let tableView = TORoundedTableView()
    private let headerView = LoginHeaderView()
    private let footerView = LoginFooterView()
    private let copyrightView = UILabel()
    
    private var effectView: UIVisualEffectView?
    private var backgroundView: UIView?
    
    /* State tracking */
    private var _registering: Bool = false
    private var keyboardHeight: CGFloat = 0.0
    
    /* Login/Register Credentials */
    private var serverURL: String?       { didSet { validateFormItems() } }
    private var email: String?           { didSet { validateFormItems() } }
    private var password: String?        { didSet { validateFormItems() } }
    private var confirmPassword: String? { didSet { validateFormItems() } }
    private var rememberLogin: Bool = true
    
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
        
        transitioningDelegate = self
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
    }
    
    private func setUpCommonViews() {
        backgroundView = UIView()
        backgroundView?.frame = view.bounds
        backgroundView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundView!)
        
        containerView.frame = view.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(containerView)
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.maximumWidth = 500
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.delaysContentTouches = false
        containerView.addSubview(tableView)
        
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
        containerView.addSubview(copyrightView)
        
        applyTheme()
    }
    
    func applyTheme() {
        
        // view accessory views
        navigationBar.barStyle  = isDarkStyle ? .blackTranslucent : .default
        copyrightView.textColor = isDarkStyle ? UIColor(white: 0.3, alpha: 1.0) : UIColor(white: 0.6, alpha: 1.0)
        
        // view background
        if isTranslucent {
            backgroundView?.backgroundColor = UIColor(white: isDarkStyle ? 0.1 : 0.9, alpha: 0.3)
        }
        else {
            backgroundView?.backgroundColor = UIColor(white: isDarkStyle ? 0.15 : 0.95, alpha: 1.0)
        }
        
        if effectView != nil {
            effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        }
        
        // table accessory views
        headerView.style = isDarkStyle ? .dark : .light
        footerView.style = isDarkStyle ? .dark : .light
        
        // table view and cells
        tableView.separatorColor = isDarkStyle ? UIColor(white: 0.4, alpha: 1.0) : nil
        tableView.cellBackgroundColor = UIColor(white: isDarkStyle ? 0.2 : 1.0, alpha: 1.0)
    }
    
    func applyTheme(to tableViewCell: LoginTableViewCell) {
        tableViewCell.imageView?.tintColor = UIColor(white: isDarkStyle ? 0.4 : 0.6, alpha: 1.0)
        tableViewCell.textLabel?.textColor = isDarkStyle ? .white : .black
        
        // Only touch the text field if we're actively using it
        if tableViewCell.textChangedHandler != nil {
            tableViewCell.textField.textColor = isDarkStyle ? .white : .black
            
            if isDarkStyle {
                let placeholderText = tableViewCell.textField.placeholder
                let placeholderTextColor = UIColor(white: 0.45, alpha: 1.0)
                let attributes = [NSForegroundColorAttributeName: placeholderTextColor]
                tableViewCell.textField.attributedPlaceholder =  NSAttributedString(string: placeholderText!, attributes: attributes)
            }
            else {
                let placeholderText = tableViewCell.textField.placeholder
                tableViewCell.textField.attributedPlaceholder = nil //setting this as nil also sets `placeholder` to nil
                tableViewCell.textField.placeholder = placeholderText
            }
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
        copyrightView.isHidden = tableView.contentSize.height > tableView.bounds.height
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
    
    //MARK: - State Management
    private func validateFormItems() {
        var formIsValid = true
        
        if serverURL?.range(of: ".") == nil {
            formIsValid = false
        }
        
        if email?.range(of: "@") == nil || email?.range(of: ".") == nil {
            formIsValid = false
        }
        
        if password?.characters.count == 0 {
            formIsValid = false
        }
        
        if isRegistering && confirmPassword?.characters.count == 0 {
            formIsValid = false
        }
        
        if isRegistering && password != confirmPassword {
            formIsValid = false
        }
        
        footerView.isSubmitButtonEnabled = formIsValid
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
            navigationBar.alpha = 1.0 - ((abs(verticalOffset) - statusBarFrameHeight) / 10.0)
        }
        
        // Offset the copyright label
        let normalizedOffset = verticalOffset + scrollView.contentInset.top
        copyrightView.frame.origin.y = (view.bounds.height - copyrightViewMargin) - normalizedOffset
    }
    
    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isRegistering ? 5 : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LoginTableViewCell
        if cell == nil {
            cell = LoginTableViewCell(style: .default, reuseIdentifier: identifier)
        }
    
        let lastCellIndex = !isRegistering ? 3 : 4
        
        // Configure rounded caps
        cell?.topCornersRounded    = (indexPath.row == 0)
        cell?.bottomCornersRounded = (indexPath.row == lastCellIndex)
        
        cell?.imageView?.image = image(forRow: indexPath.row)
        
        if indexPath.row == lastCellIndex {
            cell?.textLabel!.text = "Remember My Account"
            cell?.switch.isOn = rememberLogin
            cell?.switchChangedHandler = { self.rememberLogin = (cell?.switch.isOn)! }
        }
        else {
            let textField = cell!.textField
            
            switch indexPath.row {
            case 0:
                textField.placeholder = "Server URL"
                textField.text = serverURL
                textField.keyboardType = .URL
                cell?.textChangedHandler = { self.serverURL = textField.text }
                cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: 1) }
            case 1:
                textField.placeholder = "Email Address"
                textField.text = email
                textField.keyboardType = .emailAddress
                cell?.textChangedHandler = { self.email = textField.text }
                cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: 2) }
            case 2:
                textField.placeholder = "Password"
                textField.text = password
                textField.isSecureTextEntry = true
                textField.returnKeyType = isRegistering ? .next : .done
                cell?.textChangedHandler = { self.password = textField.text }
                cell?.returnButtonTappedHandler = {
                    if self.isRegistering {
                        self.makeFirstResponder(atRow: 3)
                    }
                    else {
                        // Submit Form
                    }
                }
            case 3:
                textField.placeholder = "Confirm Password"
                textField.text = confirmPassword
                textField.isSecureTextEntry = true
                textField.returnKeyType = .done
                cell?.textChangedHandler = { self.confirmPassword = textField.text }
                cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: 1) }
                cell?.returnButtonTappedHandler = { /* Begin Submission */ }
            default:
                break
            }

        }
        
        // Apply the theme after all cell configuration is done
        applyTheme(to: cell!)
        
        return cell!
    }
    
    private func image(forRow row: Int) -> UIImage {
        switch row {
        case 0: return earthIcon
        case 1: return mailIcon
        case 2: return lockIcon
        case 3: return isRegistering ? lockIcon : tickIcon
        case 4: return tickIcon
        default: return mailIcon
        }
    }
    
    // MARK: - Login/Register Transition
    
    func setRegistering(_ registering: Bool, animated: Bool) {
        guard _registering != registering else {
            return
        }
        
        _registering = registering
        
        // Insert/Delete the 'confirm password' field
        if _registering {
            tableView.insertRows(at: [IndexPath(row: 3, section: 0)], with: .fade)
        }
        else {
            tableView.deleteRows(at: [IndexPath(row: 3, section: 0)], with: .fade)
        }
        
        // Reload the middle row to refresh its cap graphics
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)], with: .none)
        
        // Animate the content size adjustments
        animateContentInsetTransition()
        
        // Update the accessory views
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
    
    //MARK: - View Controller Transitioning
        
    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = backgroundView
        animationController.contentView = containerView
        animationController.effectsView = effectView
        animationController.isDismissing = false
        return animationController
    }
    
    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = backgroundView
        animationController.contentView = containerView
        animationController.effectsView = effectView
        animationController.isDismissing = true
        return animationController
    }
    
    
}
