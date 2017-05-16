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

/** The visual styles in which the login controller can be displayed. */
@objc public enum LoginViewControllerStyle: Int {
    case lightTranslucent /* Light theme, with a translucent background showing the app content poking through. */
    case lightOpaque      /* Light theme, with a solid background color. */
    case darkTranslucent  /* Dark theme, with a translucent background showing the app content poking through. */
    case darkOpaque       /* Dark theme, with a solid background color. */
}

/** A protocol for third party objects to integrate with and manage the authentication 
    of user credentials. Used for integration with third party services like Amazon Cognito.
 */
@objc(RLMAuthenticationProvider)
public protocol AuthenticationProvider: NSObjectProtocol {

    /** The credentials captured by the login controller (if set) */
    var username: String? { get set }
    var password: String? { get set }
    var isRegistering: Bool   { get set }

    /**
     The provider will perform the necessary requests (asynchronously if desired) to obtain the
     required information from the third party service that can then be used to
     create an `RLMSynCredentials` object for input into the ROS Authentication server.
     */
    func authenticate(onCompletion: ((RLMSyncCredentials?, Error?) -> Void)?)

    /**
     Not strictly required, but if the sign-in request is asynchronous and needs to be cancelled,
     this will be called to give the logic a chance to clean itself up.
     */
    func cancelAuthentication() -> Void
}

/** 
 A view controller showing an inpur form for logging into a Realm Object Server instance running
 on a remote server.
 */
@objc(RLMLoginViewController)
public class LoginViewController: UIViewController {
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    public private(set) var style = LoginViewControllerStyle.lightTranslucent

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
     Whether the request to the authentication server will occur over HTTPS, or plain
     HTTP.
     
     Setting this value to `true` will always force a secure connection. It may be optionally
     enabled if the server URL is prefixed with a protocol ending in 's' (eg 'https', 'realms')
     */
    public var isSecureConnection: Bool {
        get {
            if _isSecureConnection { return true }
            if let scheme = serverURL?.URLScheme {
                return scheme.characters.last! == "s"
            }

            return false
        }
        set { _isSecureConnection = newValue }
    }

    /**
     Sets whether the copyright label shown at the bottom of the
     view is visible or not.
     */
    public var isCopyrightLabelHidden: Bool {
        get { return self.loginView.isCopyrightLabelHidden }
        set { self.loginView.isCopyrightLabelHidden = newValue }
    }

    /**
     Sets the text shown in the copyright label.
     */
    public var copyrightLabelText: String {
        get { return self.loginView.copyrightLabelText }
        set { self.loginView.copyrightLabelText = newValue }
    }

    /**
     The port number that will be appended to the server URL when constructing the final
     authentication URL, if the server has been set as unsecure. Default value is 9080.
     Specifying a port in `serverURL` will override this value.
     */
    public var serverPortNumber: Int {
        set { _defaultPortNumber = newValue }
        get {
            let portNumber = serverURL!.URLPortNumber
            return portNumber >= 0 ? portNumber : _defaultPortNumber
        }
    }

    public var serverSecurePortNumber: Int {
        set { _defaultSecurePortNumber = newValue }
        get {
            let portNumber = serverURL!.URLPortNumber
            return portNumber >= 0 ? portNumber : _defaultSecurePortNumber
        }
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
     Transitions the view controller between the 'logging in' and 'signing up'
     states. Can be animated, or updated instantly.
     */
    public func setRegistering(_ isRegistering: Bool, animated: Bool) {
        guard _isRegistering != isRegistering else { return }
        _isRegistering = isRegistering
        tableDataSource.setRegistering(isRegistering, animated: animated)
        loginView.setRegistering(isRegistering, animated: animated)
        prepareForSubmission()
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
     With all of the available credentials, the final URL that will be used
     for the request to the Realm Authentication Server
    */
    public var authenticationRequestURL: URL? {
        guard let serverHost = serverURL?.URLHost else { return nil }
        let scheme: String, portNumber: Int

        scheme = isSecureConnection ? "https" : "http"
        portNumber = isSecureConnection ? serverSecurePortNumber : serverPortNumber

        return URL(string: "\(scheme)://\(serverHost):\(portNumber)")
    }

    /**
     When integrating with third party services that require another web service to
     verify the credentials before they are submitted to the Realm authentication server,
     this property can be set to an object capable of performing this request and generation
     the subsequent `RLMSyncCredentials` objects.
    */
    public var authenticationProvider: AuthenticationProvider?

    /**
     A model object that exposes the input validation logic of the form
     */
    public lazy var formValidationManager: LoginCredentialsValidationProtocol = LoginCredentialsValidation()

    //MARK: - Private Properties

    /* State tracking */
    private var _isRegistering = false
    private var _isSecureConnection = false
    private var _defaultPortNumber = 9080
    private var _defaultSecurePortNumber = 9443

    /* The `UIView` subclass that manages all view content in this view controller */
    private var loginView: LoginView {
        return (self.view as! LoginView)
    }

    /* A view model object to manage the table view */
    private let tableDataSource = LoginTableViewDataSource()

    /* A model object to manage receiving keyboard resize events from the system. */
    private let keyboardManager = LoginKeyboardManager()

    /* A coordinator object for managing saving and retreiving previous login credential sets */
    private let savedCredentialsCoordinator = LoginPersistedCredentialsCoordinator()

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
        modalPresentationStyle = isTranslucent ? .overFullScreen : .fullScreen
        modalTransitionStyle = .crossDissolve
        modalPresentationCapturesStatusBarAppearance = true
    }

    convenience init() {
        self.init(style: .lightTranslucent)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        authenticationProvider?.cancelAuthentication()
    }

    //MARK: - View Management

    override public func loadView() {
        super.loadView()
        self.view = LoginView(darkStyle: isDarkStyle, translucentStyle: isTranslucent)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = loginView

        // Set up the data source for the table view
        tableDataSource.isDarkStyle = isDarkStyle
        tableDataSource.tableView = loginView.tableView
        tableDataSource.formInputChangedHandler = { self.prepareForSubmission() }

        // Set callbacks for the accessory view buttons
        loginView.didTapCloseHandler = { self.dismiss(animated: true, completion: nil) }
        loginView.didTapLogInHandler = { self.submitLoginRequest() }
        loginView.didTapRegisterHandler = { self.setRegistering(!self.isRegistering, animated: true) }

        // Configure the keyboard manager for the login view
        keyboardManager.keyboardHeightDidChangeHandler = { newHeight in
            self.loginView.keyboardHeight = newHeight
            self.loginView.animateContentInsetTransition()
        }

        loadLoginCredentials()
        prepareForSubmission()
        loginView.updateCloseButtonVisibility()
    }

    private func loadLoginCredentials() {
        guard let credentials = self.savedCredentialsCoordinator.allCredentialsObjects?.firstObject() else { return }
        self.serverURL = credentials.serverURL
        self.username = credentials.username
        self.password = credentials.password
    }

    //MARK: - Form Submission -

    private func prepareForSubmission() {
        // Validate the supplied credentials
        var isFormValid = true

        // Check each credential against our external validator
        isFormValid = formValidationManager.isValidServerURL(serverURL) && isFormValid
        isFormValid = formValidationManager.isValidUsername(username) && isFormValid
        isFormValid = formValidationManager.isValidPassword(password) && isFormValid

        // If registering, confirm password matches the confirm password field too
        if isRegistering {
            isFormValid = isFormValid && formValidationManager.isPassword(password, matching: confirmPassword)
        }

        // Enable the 'submit' button if all is valid
        loginView.footerView.isSubmitButtonEnabled = isFormValid
    }

    private func submitLoginRequest() {
        // Show the spinner view on the login button
        loginView.footerView.isSubmitting = true

        // Make sure we have a valid URL for the Realm Authentication Server
        guard let authenticationURL = authenticationRequestURL else { return }

        // Create the callback block that will perform the request
        let logInBlock: ((RLMSyncCredentials) -> Void) = { credentials in
            RLMSyncUser.__logIn(with: credentials, authServerURL: authenticationURL, timeout: 30, onCompletion: { (user, error) in
                DispatchQueue.main.async {
                    // Display an error message if the login failed
                    if let error = error {
                        self.loginView.footerView.isSubmitting = false
                        self.showError(title: "Unable to Sign In", message: error.localizedDescription)
                        return
                    }

                    // Save the credentials so they can be re-used next time
                    if self.rememberLogin {
                        try! self.savedCredentialsCoordinator.saveCredentials(serverURL: self.serverURL!, username: self.username!,
                                                                              password: self.password!)
                    }

                    // Inform the parent that the login was successful
                    self.loginSuccessfulHandler?(user!)
                }
            })
        }

        // If an authentication provider was supplied, allow it to perform the necessary requests to generate a credentials object
        if let authenticationProvider = self.authenticationProvider {
            // Copy over the current credentials
            authenticationProvider.username = self.username!
            authenticationProvider.password = self.password!
            authenticationProvider.isRegistering = self.isRegistering

            // Perform the request
            authenticationProvider.authenticate { credentials, error in
                // The credentials were successfully generated by the provider
                if let credentials = credentials {
                    logInBlock(credentials)
                    return
                }

                // Show an error dialog if an error was supplied
                if let error = error {
                    self.showError(title: "Unable to Sign In", message: error.localizedDescription)
                }

                // Hide the spinning indicator
                self.loginView.footerView.isSubmitting = false
            }
        }
        else {
            let credentials = RLMSyncCredentials(username: username!, password: password!, register: isRegistering)
            logInBlock(credentials)
        }
    }

    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
