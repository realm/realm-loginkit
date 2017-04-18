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
public class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    public private(set) var style = LoginViewControllerStyle.lightTranslucent
    
    /**
     Whether the view controller will allow new registrations, or
     simply only allow previously registered accounts to be entered.
    */
    public var allowsNewAccountRegistration: Bool {
        get { return self.loginView.canRegisterNewAccounts }
        set { self.loginView.canRegisterNewAccounts = newValue }
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
    public var isServerURLFieldHidden: Bool {
        set { tableDataSource.isServerURLFieldHidden = newValue }
        get { return tableDataSource.isServerURLFieldHidden }
    }
    
    /**
     For cases where apps do not require logging in each time, the 'remember login'
     field can be hidden
    */
    public var isRememberAccountDetailsFieldHidden: Bool {
        set { tableDataSource.isRememberAccountDetailsFieldHidden = newValue }
        get { return tableDataSource.isRememberAccountDetailsFieldHidden }
    }

    /** 
     In cases where cancelling the login controller might be needed, show 
     a close button that can dismiss the view.
    */
    public var isCancelButtonHidden: Bool {
        // Proxy this property to the one managed directly by the view
        set { self.loginView.isCancelButtonHidden = newValue }
        get { return self.loginView.isCancelButtonHidden }
    }

    //MARK: - Private Properties

    /* The `UIView` subclass that manages all view content in this view controller */
    private var loginView: LoginView {
        return (self.view as! LoginView)
    }

    /* A view model object to manage the table view */
    private let tableDataSource = LoginTableViewDataSource()

    /* User default keys for saving form data */
    private static let serverURLKey = "RealmLoginServerURLKey"
    private static let emailKey     = "RealmLoginEmailKey"
    private static let passwordKey  = "RealmLoginPasswordKey"
    
    /* State tracking */
    private var _registering: Bool = false
    private var keyboardHeight: CGFloat = 0.0
    
    /* Login/Register Credentials */
    public var  serverURL: String?      { didSet { validateFormItems() } }
    public var serverPort = 9080        { didSet { validateFormItems() } }
    public var username: String?        { didSet { validateFormItems() } }
    public var password: String?        { didSet { validateFormItems() } }
    public var confirmPassword: String? { didSet { validateFormItems() } }
    public var rememberLogin: Bool = true

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
    
    //MARK: - View Management

    override public func loadView() {
        super.loadView()
        self.view = LoginView(darkStyle: isDarkStyle, translucentStyle: isTranslucent)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Set up the datasource for the table view
        tableDataSource.isDarkStyle = isDarkStyle
        loginView.tableView.dataSource = tableDataSource
        loginView.didTapCloseHandler = { self.dismiss(animated: true, completion: nil) }
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Hide the copyright view if there's not enough space on screen
        loginView.updateCopyrightViewVisibility()

        // Recalculate the state for the on-screen views
        loginView.layoutTableContentInset()
        loginView.layoutNavigationBar()
        loginView.layoutCopyrightView()
        loginView.layoutCloseButton()
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
            self.loginView.layoutTableContentInset()
            self.loginView.layoutNavigationBar()
        }, completion: nil)
        
        // When animating the table view edge insets when its rounded, the header view
        // snaps because their width override is caught in the animation block.
        loginView.tableView.tableHeaderView?.layer.removeAllAnimations()
    }

    func setRegistering(_ registering: Bool, animated: Bool) {
        guard _registering != registering else {
            return
        }

        _registering = registering

        // Animate the content size adjustments
        animateContentInsetTransition()

        // Update the accessory views
        loginView.headerView.setRegistering(_registering, animated: animated)
        loginView.footerView.setRegistering(_registering, animated: animated)

        // Hide the copyright view if needed
        UIView.animate(withDuration: animated ? 0.25 : 0.0) {
            self.loginView.updateCopyrightViewVisibility()
        }
    }

    //MARK: - View Controller Transitioning
        
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = loginView.backgroundView
        animationController.contentView = loginView.containerView
        animationController.effectsView = loginView.effectView
        animationController.controlView = loginView.closeButton
        animationController.isDismissing = false
        return animationController
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = LoginViewControllerTransitioning()
        animationController.backgroundView = loginView.backgroundView
        animationController.contentView = loginView.containerView
        animationController.effectsView = loginView.effectView
        animationController.controlView = loginView.closeButton
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

        loginView.footerView.isSubmitButtonEnabled = formIsValid
    }

    private func submitLogin() {
        loginView.footerView.isSubmitting = true
        
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
                self.loginView.footerView.isSubmitting = false
                
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
