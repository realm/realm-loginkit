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
public class LoginViewController: UIViewController {
    
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
        get { return _isRegistering }
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

    /**
     The server address URL that will form the basis of the Realm authentication
     server request URL. Including the port number will override the value in `serverPort`.
     Declaring either scheme, 'https', 'realms', will make this a secure request
    */
    public var serverURL: String? {
        set { tableDataSource.serverURL = newValue }
        get { return tableDataSource.serverURL }
    }

    /**
     The port number that will be appended to the server URL when constructing the final
     authentication URL. Default value is 9080. Specifying 'https' or 'realms' in the `serverURL`
     field will override the value to 9443.
    */
    public var serverPort: Int {
        set { tableDataSource.serverPort = newValue }
        get { return tableDataSource.serverPort }
    }

    /**
     The username of the account that will either be logged in, or registered. While an email
     address is preferred, there are no specific formatting checks, so any string is valid.
     */
    public var username: String? {
        set { tableDataSource.username = newValue }
        get { return tableDataSource.username }
    }

    /**
     The pasword for this account that is being logged in, or registered. By default, there are
     no password security policies in place.
    */
    public var password: String? {
        set { tableDataSource.password = newValue }
        get { return tableDataSource.password }
    }

    /**
     When registering a new account, this field is used to confirm the password is as the user intended.
     The form validation check will fail if the form state is set to registering, and this string doesn't
     match `password` exactly.
    */
    public var confirmPassword: String? {
        set { tableDataSource.confirmPassword = newValue }
        get { return tableDataSource.confirmPassword }
    }

    /**
     When true, the credentials of the last login will be persisted and will prefill the login form
     the next time it is opened.
    */
    public var rememberLogin: Bool {
        set { tableDataSource.rememberLogin = newValue }
        get { return tableDataSource.rememberLogin }
    }

    //MARK: - Private Properties

    /* The `UIView` subclass that manages all view content in this view controller */
    private var loginView: LoginView {
        return (self.view as! LoginView)
    }

    /* A view model object to manage the table view */
    private let tableDataSource = LoginTableViewDataSource()

    /* A model object to manage receiving keyboard resize events from the system. */
    private let keyboardManager = LoginKeyboardManager()

    /* User default keys for saving form data */
    private static let serverURLKey = "RealmLoginServerURLKey"
    private static let emailKey     = "RealmLoginEmailKey"
    private static let passwordKey  = "RealmLoginPasswordKey"
    
    /* State tracking */
    private var _isRegistering: Bool = false

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
    }
    
    convenience init() {
        self.init(style: .lightTranslucent)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: - View Management

    override public func loadView() {
        super.loadView()
        self.view = LoginView(darkStyle: isDarkStyle, translucentStyle: isTranslucent)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = loginView
        modalPresentationStyle = isTranslucent ? .overFullScreen : .fullScreen
        modalTransitionStyle = .crossDissolve
        modalPresentationCapturesStatusBarAppearance = true

        // Set up the data source for the table view
        tableDataSource.isDarkStyle = isDarkStyle
        tableDataSource.tableView = loginView.tableView

        loginView.didTapCloseHandler = { self.dismiss(animated: true, completion: nil) }

        // Configure the keyboard manager for the login view
        keyboardManager.keyboardHeightDidChangeHandler = { newHeight in
            self.loginView.keyboardHeight = newHeight
            self.loginView.animateContentInsetTransition()
        }

        // Set up the handler for when the 'Register' button is tapped
        loginView.didTapRegisterHandler = { self.setRegistering(!self.isRegistering, animated: true) }

        loadLoginCredentials()
    }

    func setRegistering(_ isRegistering: Bool, animated: Bool) {
        guard _isRegistering != isRegistering else {
            return
        }

        _isRegistering = isRegistering

        tableDataSource.setRegistering(isRegistering, animated: animated)
        loginView.setRegistering(isRegistering, animated: animated)
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
