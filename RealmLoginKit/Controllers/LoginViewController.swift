////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import UIKit
import TORoundedTableView
import Realm

@objc public enum LoginViewControllerStyle: Int {
    case lightTranslucent
    case lightOpaque
    case darkTranslucent
    case darkOpaque
}

@objc(RLMLoginViewController)
public class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    private static let serverURLKey = "RealmLoginServerURLKey"
    private static let emailKey = "RealmLoginEmailKey"
    private static let passwordKey = "RealmLoginPasswordKey"
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    public private(set) var style = LoginViewControllerStyle.lightTranslucent
    
    public var isRegistering: Bool {
        set {
            setRegistering(newValue, animated: false)
        }
        get { return _registering }
    }
    
    public var logInSuccessfulHandler: ((RLMSyncUser) -> Void)?
    
    //MARK: - Private Properties
    
    /* Assets */
    private let earthIcon = UIImage.earthIcon()
    private let lockIcon  = UIImage.lockIcon()
    private let mailIcon  = UIImage.mailIcon()
    private let tickIcon  = UIImage.tickIcon()
    
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
    public var serverURL: String?       { didSet { validateFormItems() } }
    public var email: String?           { didSet { validateFormItems() } }
    public var password: String?        { didSet { validateFormItems() } }
    public var confirmPassword: String? { didSet { validateFormItems() } }
    public var rememberLogin: Bool = true
    
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
    
    public init(style: LoginViewControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        
        transitioningDelegate = self
        modalPresentationStyle = isTranslucent ? .overFullScreen : .fullScreen
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        loadLoginCredentials()
    }
    
    convenience init() {
        self.init(style: .lightTranslucent)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        
        headerView.appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String
        
        footerView.loginButtonTapped = {
            self.submitLogin()
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        if isTranslucent {
            setUpTranslucentViews()
        }
        
        setUpCommonViews()
    }

    override public func viewDidLayoutSubviews() {
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
        
        if serverURL == nil || (serverURL?.isEmpty)! {
            formIsValid = false
        }
        
        if email?.range(of: "@") == nil || email?.range(of: ".") == nil {
            formIsValid = false
        }
        
        if password == nil || (password?.isEmpty)! {
            formIsValid = false
        }
        
        if isRegistering && password != confirmPassword {
            formIsValid = false
        }
        
        footerView.isSubmitButtonEnabled = formIsValid
    }
        
    //MARK: - Scroll View Delegate
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isRegistering ? 5 : 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                        self.submitLogin()
                    }
                }
            case 3:
                textField.placeholder = "Confirm Password"
                textField.text = confirmPassword
                textField.isSecureTextEntry = true
                textField.returnKeyType = .done
                cell?.textChangedHandler = { self.confirmPassword = textField.text }
                cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: 1) }
                cell?.returnButtonTappedHandler = { self.submitLogin() }
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
        
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = backgroundView
        animationController.contentView = containerView
        animationController.effectsView = effectView
        animationController.isDismissing = false
        return animationController
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = backgroundView
        animationController.contentView = containerView
        animationController.effectsView = effectView
        animationController.isDismissing = true
        return animationController
    }
    
    //MARK: - Form Submission
    private func submitLogin() {
        footerView.isSubmitting = true
        
        saveLoginCredentials()
        
        var formattedURL = serverURL
        if let schemeRange = formattedURL?.range(of: "://") {
            formattedURL = formattedURL?.substring(from: schemeRange.upperBound)
        }
        
        if formattedURL?.range(of: ":") == nil {
            formattedURL = "\(formattedURL!):9080"
        }
        
        let credentials = RLMSyncCredentials(username: email!, password: password!, register: isRegistering)
        RLMSyncUser.__logIn(with: credentials, authServerURL: URL(string: "http://\(formattedURL!)")!, timeout: 30, onCompletion: { (user, error) in
            DispatchQueue.main.async {
                self.footerView.isSubmitting = false
                
                if let error = error {
                    let alertController = UIAlertController(title: "Unable to Sign In", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                self.logInSuccessfulHandler?(user!)
            }
        })
    }
    
    private func saveLoginCredentials() {
        let userDefaults = UserDefaults.standard
        
        if rememberLogin {
            userDefaults.set(serverURL, forKey: LoginViewController.serverURLKey)
            userDefaults.set(email, forKey: LoginViewController.emailKey)
            userDefaults.set(password, forKey: LoginViewController.passwordKey)
        }
        else {
            userDefaults.set(nil, forKey: LoginViewController.serverURLKey)
            userDefaults.set(nil, forKey: LoginViewController.emailKey)
            userDefaults.set(nil, forKey: LoginViewController.passwordKey)
        }
        
        userDefaults.synchronize()
    }
    
    private func loadLoginCredentials() {
        let userDefaults = UserDefaults.standard
        serverURL = userDefaults.object(forKey: LoginViewController.serverURLKey) as! String?
        email = userDefaults.object(forKey:  LoginViewController.emailKey) as! String?
        password = userDefaults.object(forKey: LoginViewController.passwordKey) as! String?
    }
}
