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

/* The types of inputs cells may be */
private enum LoginViewControllerCellType: Int {
    case serverURL
    case email
    case password
    case confirmPassword
    case rememberLogin
}

@objc(RLMLoginViewController)
public class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    public private(set) var style = LoginViewControllerStyle.lightTranslucent
    
    /**
     Whether the view controller will allow new registrations, or
     simply only allow previously registered accounts to be entered.
    */
    public var allowsNewAccountRegistration: Bool = true {
        didSet {
            footerView.isRegisterButtonHidden = !allowsNewAccountRegistration
            tableView.reloadData()
        }
    }
    
    /**
     Manages whether the view controller is currently logging in an existing user,
     or registering a new user for the first time
    */
    public var isRegistering: Bool {
        set {
            setRegistering(newValue, animated: false)
        }
        get { return _registering }
    }
    
    /**
     Upon successful login/registration, this callback block will be called,
     providing the user account object that was returned by the server.
    */
    public var loginSuccessfulHandler: ((RLMSyncUser) -> Void)?
    
    /**
     For cases where apps will be connecting to a pre-established server URL,
     this option can be used to hide the 'server address' field
    */
    public var isServerURLFieldHidden: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    /**
     For cases where apps do not require logging in each time, the 'remember login'
     field can be hidden
    */
    public var isRememberAccountDetailsFieldHidden: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }

    /** 
     In cases where cancelling the login controller might be needed, show 
     a close button that can dismiss the view.
    */
    public var isCancelButtonHidden = true {
        didSet {
            setUpCloseButton()
        }
    }

    //MARK: - Private Properties
    
    /* User default keys for saving form data */
    private static let serverURLKey = "RealmLoginServerURLKey"
    private static let emailKey     = "RealmLoginEmailKey"
    private static let passwordKey  = "RealmLoginPasswordKey"
    
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
    private var closeButton: UIButton? = nil
    
    private var effectView: UIVisualEffectView?
    private var backgroundView: UIView?
    
    /* State tracking */
    private var _registering: Bool = false
    private var keyboardHeight: CGFloat = 0.0
    
    /* Login/Register Credentials */
    public var serverURL: String?       { didSet { validateFormItems() } }
    public var serverPort = 9080        { didSet { validateFormItems() } }
    public var username: String?        { didSet { validateFormItems() } }
    public var password: String?        { didSet { validateFormItems() } }
    public var confirmPassword: String? { didSet { validateFormItems() } }
    public var rememberLogin: Bool = true
    
    /* Layout Constants */
    private let copyrightViewMargin: CGFloat = 45
    private let closeButtonInset = UIEdgeInsets(top: 15, left: 18, bottom: 0, right: 0)

    /* State Convienience Methods */
    private var isTranslucent: Bool  {
        return style == .lightTranslucent || style == .darkTranslucent
    }
    
    private var isDarkStyle: Bool {
        return style == .darkTranslucent || style == .darkOpaque
    }
    
    //MARK: - Status Bar Appearance
    override public var prefersStatusBarHidden: Bool { return false }
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkStyle ? .lightContent : .default
    }
    
    //MARK: - Class Creation
    
    public init(style: LoginViewControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        
        transitioningDelegate = self
        modalPresentationStyle = isTranslucent ? .overFullScreen : .fullScreen
        modalTransitionStyle = .crossDissolve
        modalPresentationCapturesStatusBarAppearance = true
        
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

    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }

    //MARK: - View Setup
    
    private func setUpTranslucentViews() {
        effectView = UIVisualEffectView()
        effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        effectView?.frame = view.bounds
        effectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(effectView!)
    }

    private func setUpTableView() {
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

        let infoDictionary = Bundle.main.infoDictionary!
        if let displayName = infoDictionary["CFBundleDisplayName"] {
            headerView.appName = displayName as? String
        }
        else if let displayName = infoDictionary[kCFBundleNameKey as String] {
            headerView.appName = displayName as? String
        }

        footerView.loginButtonTapped = {
            self.submitLogin()
        }

        footerView.registerButtonTapped = {
            self.setRegistering(!self.isRegistering, animated: true)
        }
    }

    private func setUpCloseButton() {
        //Check if we're already set up
        if isCancelButtonHidden && closeButton == nil { return }
        if !isCancelButtonHidden && closeButton != nil { return }

        if isCancelButtonHidden {
            closeButton?.removeFromSuperview()
            closeButton = nil
            return
        }

        let closeIcon = UIImage.closeIcon()
        closeButton = UIButton(type: .system)
        closeButton?.setImage(closeIcon, for: .normal)
        closeButton?.frame = CGRect(origin: .zero, size: closeIcon.size)
        closeButton?.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        view.addSubview(closeButton!)
    }

    private func setUpCommonViews() {
        backgroundView = UIView()
        backgroundView?.frame = view.bounds
        backgroundView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(backgroundView!)
        
        containerView.frame = view.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(containerView)

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

        setUpTableView()
        setUpCloseButton()

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

        if closeButton != nil {
            let greyShade = isDarkStyle ? 1.0 : 0.2
            closeButton?.tintColor = UIColor(white: CGFloat(greyShade), alpha: 1.0)
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
            tableViewCell.textField?.textColor = isDarkStyle ? .white : .black
            tableViewCell.textField?.keyboardAppearance = isDarkStyle ? .dark : .default

            if isDarkStyle {
                let placeholderText = tableViewCell.textField?.placeholder
                let placeholderTextColor = UIColor(white: 0.45, alpha: 1.0)
                let attributes = [NSForegroundColorAttributeName: placeholderTextColor]
                tableViewCell.textField?.attributedPlaceholder =  NSAttributedString(string: placeholderText!, attributes: attributes)
            }
            else {
                let placeholderText = tableViewCell.textField?.placeholder
                tableViewCell.textField?.attributedPlaceholder = nil //setting this as nil also sets `placeholder` to nil
                tableViewCell.textField?.placeholder = placeholderText
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

        // Hide the copyright view if there's not enough space on screen
        updateCopyrightViewVisibility()

        // Recalculate the state for the on-screen views
        layoutTableContentInset()
        layoutNavigationBar()
        layoutCopyrightView()
        layoutCloseButton()
    }

    private func layoutTableContentInset() {

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
        topPadding += (UIApplication.shared.statusBarFrame.height + 10)

        var bottomPadding:CGFloat = 0.0
        if keyboardHeight > 0 {
            bottomPadding = keyboardHeight + 15
        }

        var edgeInsets = tableView.contentInset
        edgeInsets.top = topPadding
        edgeInsets.bottom = bottomPadding
        tableView.contentInset = edgeInsets
    }

    private func layoutNavigationBar() {
        if UIApplication.shared.isStatusBarHidden {
            navigationBar.alpha = 0.0
            return
        }

        let statusBarFrameHeight = UIApplication.shared.statusBarFrame.height
        navigationBar.frame.size.height = statusBarFrameHeight

        // Show the navigation bar when content starts passing under the status bar
        let verticalOffset = self.tableView.contentOffset.y

        if verticalOffset >= -statusBarFrameHeight {
            navigationBar.alpha = 1.0
        }
        else if verticalOffset <= -(statusBarFrameHeight + 10) {
            navigationBar.alpha = 0.0
        }
        else {
            navigationBar.alpha = 1.0 - ((abs(verticalOffset) - statusBarFrameHeight) / 10.0)
        }
    }

    private func updateCopyrightViewVisibility() {
        // Hide the copyright if there's not enough vertical space on the screen for it to not
        // interfere with the rest of the content
        let isHidden = (tableView.contentInset.top + tableView.contentSize.height) > copyrightView.frame.minY
        copyrightView.alpha = isHidden ? 0.0 : 1.0
    }

    private func updateCloseButtonVisibility() {
        guard let closeButton = self.closeButton else {
            return
        }

        guard self.traitCollection.horizontalSizeClass == .compact else {
            closeButton.alpha = 1.0
            return
        }

        let titleLabel = self.headerView.titleLabel
        let yOffset = titleLabel.frame.origin.y - tableView.contentOffset.y
        let thresholdY = closeButton.frame.maxY
        let normalizedOffset = yOffset - thresholdY
        var alpha = normalizedOffset / 30.0
        alpha = min(1.0, alpha); alpha = max(0.0, alpha)
        closeButton.alpha = alpha
    }

    private func layoutCopyrightView() {
        guard copyrightView.isHidden == false else {
            return
        }

        // Offset the copyright label
        let verticalOffset = tableView.contentOffset.y
        let normalizedOffset = verticalOffset + tableView.contentInset.top
        copyrightView.frame.origin.y = (view.bounds.height - copyrightViewMargin) - normalizedOffset
    }

    private func layoutCloseButton() {
        guard let closeButton = self.closeButton else {
            return
        }

        let statusBarFrame = UIApplication.shared.statusBarFrame

        var rect = closeButton.frame
        rect.origin.x = closeButtonInset.left
        rect.origin.y = statusBarFrame.size.height + closeButtonInset.top
        closeButton.frame = rect
    }

    //MARK: - Scroll View Delegate
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        layoutNavigationBar()
        layoutCopyrightView()
        updateCloseButtonVisibility()
    }

    //MARK: - Table View Data Source

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = isRegistering ? 5 : 4
        if isServerURLFieldHidden { numberOfRows -= 1 }
        if isRememberAccountDetailsFieldHidden { numberOfRows -= 1 }
        return numberOfRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LoginTableViewCell
        if cell == nil {
            cell = LoginTableViewCell(style: .default, reuseIdentifier: identifier)
        }

        let lastCellIndex = tableView.numberOfRows(inSection: 0) - 1

        // Configure rounded caps
        cell?.topCornersRounded    = (indexPath.row == 0)
        cell?.bottomCornersRounded = (indexPath.row == lastCellIndex)

        // Configure cell content
        switch cellType(for: indexPath.row) {
        case .serverURL:
            cell?.type = .textField
            cell?.imageView?.image = earthIcon
            cell?.textField?.placeholder = "Server URL"
            cell?.textField?.text = serverURL
            cell?.textField?.keyboardType = .URL
            cell?.textChangedHandler = { self.serverURL = cell?.textField?.text }
            cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: indexPath.row + 1) }
        case .email:
            cell?.type = .textField
            cell?.imageView?.image = mailIcon
            cell?.textField?.placeholder = "Username"
            cell?.textField?.text = username
            cell?.textField?.keyboardType = .emailAddress
            cell?.textChangedHandler = { self.username = cell?.textField?.text }
            cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: indexPath.row + 1) }
        case .password:
            cell?.type = .textField
            cell?.imageView?.image = lockIcon
            cell?.textField?.placeholder = "Password"
            cell?.textField?.text = password
            cell?.textField?.isSecureTextEntry = true
            cell?.textField?.returnKeyType = isRegistering ? .next : .done
            cell?.textChangedHandler = { self.password = cell?.textField?.text }
            cell?.returnButtonTappedHandler = {
                if self.isRegistering { self.makeFirstResponder(atRow: indexPath.row + 1) }
                else { self.submitLogin() }
            }
        case .confirmPassword:
            cell?.type = .textField
            cell?.imageView?.image = lockIcon
            cell?.textField?.placeholder = "Confirm Password"
            cell?.textField?.text = confirmPassword
            cell?.textField?.isSecureTextEntry = true
            cell?.textField?.returnKeyType = .done
            cell?.textChangedHandler = { self.confirmPassword = cell?.textField?.text }
            cell?.returnButtonTappedHandler = { self.submitLogin() }
        case .rememberLogin:
            cell?.type = .toggleSwitch
            cell?.imageView?.image = tickIcon
            cell?.textLabel!.text = "Remember My Account"
            cell?.switch?.isOn = rememberLogin
            cell?.switchChangedHandler = { self.rememberLogin = (cell?.switch?.isOn)! }
        }

        // Apply the theme after all cell configuration is done
        applyTheme(to: cell!)

        return cell!
    }

    private func cellType(for rowIndex: Int) -> LoginViewControllerCellType {
        switch rowIndex {
            case 0: return isServerURLFieldHidden ? .email : .serverURL
            case 1: return isServerURLFieldHidden ? .password : .email
            case 2:
                if isServerURLFieldHidden && !isRegistering {
                    return .rememberLogin
                }
                else if isRegistering && isServerURLFieldHidden {
                    return .confirmPassword
                }
                else {
                    return .password
                }
            case 3:
                if isRegistering && !isServerURLFieldHidden {
                    return .confirmPassword
                }
                else {
                    return .rememberLogin
                }
            case 4: return .rememberLogin
            default: return .email
        }
        
    }

    // MARK: - Login/Register Transition

    func setRegistering(_ registering: Bool, animated: Bool) {
        guard _registering != registering else {
            return
        }

        _registering = registering

        let rowIndex = isServerURLFieldHidden ? 2 : 3
        
        // Insert/Delete the 'confirm password' field
        if _registering {
            tableView.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: .fade)
            tableView.reloadRows(at: [IndexPath(row: rowIndex - 1, section: 0)], with: .none)
        }
        else {
            tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .fade)
            tableView.reloadRows(at: [IndexPath(row: rowIndex - 1, section: 0)], with: .none)
        }
        
        // Animate the content size adjustments
        animateContentInsetTransition()
        
        // Update the accessory views
        headerView.setRegistering(_registering, animated: animated)
        footerView.setRegistering(_registering, animated: animated)

        // Hide the copyright view if needed
        UIView.animate(withDuration: animated ? 0.25 : 0.0) {
            self.updateCopyrightViewVisibility()
        }
    }
    
    // MARK: - Keyboard Handling
    func makeFirstResponder(atRow row: Int) {
        let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! LoginTableViewCell
        cell.textField?.becomeFirstResponder()
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
            self.layoutNavigationBar()
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
        animationController.controlView = closeButton
        animationController.isDismissing = false
        return animationController
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = backgroundView
        animationController.contentView = containerView
        animationController.effectsView = effectView
        animationController.controlView = closeButton
        animationController.isDismissing = true
        return animationController
    }
    
    //MARK: - Form Submission
    private func validateFormItems() {
        var formIsValid = true

        if serverURL == nil || (serverURL?.isEmpty)! {
            formIsValid = false
        }

        if !(0...65535 ~= serverPort) {
            formIsValid = false
        }

        if username == nil || username!.isEmpty {
            formIsValid = false
        }

        if password == nil || password!.isEmpty {
            formIsValid = false
        }

        if isRegistering && password != confirmPassword {
            formIsValid = false
        }

        footerView.isSubmitButtonEnabled = formIsValid
    }

    private func submitLogin() {
        footerView.isSubmitting = true
        
        saveLoginCredentials()
        
        var authScheme = "http"
        var scheme: String?
        var formattedURL = serverURL
        if let schemeRange = formattedURL?.range(of: "://") {
            scheme = formattedURL?.substring(to: schemeRange.lowerBound)
            if scheme == "realms" || scheme == "https" {
                serverPort = 9443
                authScheme = "https"
            }
            formattedURL = formattedURL?.substring(from: schemeRange.upperBound)
        }
        if let portRange = formattedURL?.range(of: ":") {
            if let portString = formattedURL?.substring(from: portRange.upperBound) {
                serverPort = Int(portString) ?? serverPort
            }
            formattedURL = formattedURL?.substring(to: portRange.lowerBound)
        }
        
        let credentials = RLMSyncCredentials(username: username!, password: password!, register: isRegistering)
        RLMSyncUser.__logIn(with: credentials, authServerURL: URL(string: "\(authScheme)://\(formattedURL!):\(serverPort)")!, timeout: 30, onCompletion: { (user, error) in
            DispatchQueue.main.async {
                self.footerView.isSubmitting = false
                
                if let error = error {
                    let alertController = UIAlertController(title: "Unable to Sign In", message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                self.loginSuccessfulHandler?(user!)
            }
        })
    }
    
    private func saveLoginCredentials() {
        let userDefaults = UserDefaults.standard
        
        if rememberLogin {
            userDefaults.set(serverURL, forKey: LoginViewController.serverURLKey)
            userDefaults.set(username, forKey: LoginViewController.emailKey)
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
        serverURL = userDefaults.string(forKey: LoginViewController.serverURLKey)
        username = userDefaults.string(forKey:  LoginViewController.emailKey)
        password = userDefaults.string(forKey: LoginViewController.passwordKey)
    }
}
