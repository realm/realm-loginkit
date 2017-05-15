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
import Realm
import AWSCognitoIdentityProvider

public class AWSCognitoAuthenticationProvider: NSObject, AuthenticationProvider, AWSCognitoIdentityInteractiveAuthenticationDelegate {

    // Authentican Provider Input Credentials
    public var username: String? = nil
    public var password: String? = nil
    public var isRegistering: Bool = false

    // AWS Account Credentials
    private let serviceRegion: AWSRegionType
    private let userPoolID: String
    private let clientID: String
    private let clientSecret: String
    private let userPool: AWSCognitoIdentityUserPool

    // Task token to let us cancel requests as needed
    private var cancellationTokenSource: AWSCancellationTokenSource?

    public init(serviceRegion: AWSRegionType, userPoolID: String, clientID: String, clientSecret: String) {
        // Capture the Cognito account tokens + settings
        self.serviceRegion = serviceRegion
        self.userPoolID = userPoolID
        self.clientID = clientID
        self.clientSecret = clientSecret

        // Access the User Pool object containing our users
        let serviceConfiguration = AWSServiceConfiguration(region: self.serviceRegion, credentialsProvider: nil)
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: self.clientID, clientSecret: self.clientSecret, poolId: self.userPoolID)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey:"RealmLoginKit")
        self.userPool = AWSCognitoIdentityUserPool(forKey: "RealmLoginKit")

        super.init()
        
        self.userPool.delegate = self
    }

    public func cancelAuthentication() {
        cancellationTokenSource?.cancel()
    }

    public func authenticate(onCompletion: ((RLMSyncCredentials?, Error?) -> Void)?) {
        // Cancel any previous operations if they are still pending
        cancellationTokenSource?.cancel()
        cancellationTokenSource = nil

        // Create a new cancellation token source
        cancellationTokenSource = AWSCancellationTokenSource()

        // Trigger either a new reigstration or an existing login
        if self.isRegistering {
            registerNewAccount(onCompletion: onCompletion)
        }
        else {
            logIntoExistingAccount(onCompletion: onCompletion)
        }
    }

    private func registerNewAccount(onCompletion: ((RLMSyncCredentials?, Error?) -> Void)?) {
        // Any additional, potentially required attributes submitted along with the username and password credentials
        let attributes = [AWSCognitoIdentityUserAttributeType(name: "email", value: username!)]

        // The block called when the response from the user session request is complete
        let getUserSessionBlock: ((AWSTask<AWSCognitoIdentityUserSession>) -> Void) = { task in
            if (task.error != nil) {
                onCompletion?(nil, self.formattedError(task.error! as NSError))
                return
            }

            let session = task.result!
            print("Access token is \(session.accessToken!). Please 'confirm' user from the dashboard to continue.")
        }

        // The block called when the response from a signup request is received
        let signUpBlock: ((AWSTask<AWSCognitoIdentityUserPoolSignUpResponse>) -> Void) = { task in
            if (task.error != nil) {
                onCompletion?(nil, self.formattedError(task.error! as NSError))
                return
            }

            let response = task.result!
            response.user.getSession().continueWith(block: { task -> Any? in
                DispatchQueue.main.async { getUserSessionBlock(task) }
                return nil
            }, cancellationToken: self.cancellationTokenSource!.token)
        }

        // Make the initial signup request to the Cognito User Pool
        self.userPool.signUp(username!, password: password!, userAttributes: attributes, validationData: nil).continueWith(block: { task -> Any? in
            DispatchQueue.main.async { signUpBlock(task) }
            return nil
        }, cancellationToken: cancellationTokenSource!.token)
    }

    private func logIntoExistingAccount(onCompletion: ((RLMSyncCredentials?, Error?) -> Void)?) {
        // Set up the block that will be called when we get a response from the server
        let getUserSessionBlock: ((AWSTask<AWSCognitoIdentityUserSession>) -> Void) = { task in
            if (task.error != nil) {
                onCompletion?(nil, self.formattedError(task.error! as NSError))
                return
            }

            let userSession = task.result!

            // Extract the token from the user session and set up the resulting SyncCredentials objects
            let credentials = RLMSyncCredentials(customToken: userSession.accessToken!.tokenString, provider: RLMIdentityProvider(rawValue: "cognito"), userInfo: nil)
            onCompletion?(credentials, nil)
        }

        // Perform the login request
        let user = self.userPool.getUser(username!)
        user.getSession(username!, password: password!, validationData: nil).continueWith(block: { task -> Any? in
            DispatchQueue.main.async { getUserSessionBlock(task) }
            return nil
        }, cancellationToken: cancellationTokenSource!.token)
    }

    // Cognito returns the error message in a "message" property in
    // 'userInfo'. This method copies that string to 'localizedDescription' 
    // for easier access
    private func formattedError(_ error: NSError) -> NSError {
        var userInfo = error.userInfo
        userInfo[NSLocalizedDescriptionKey] = userInfo["message"]
        return NSError(domain: error.domain, code: error.code, userInfo: userInfo)
    }
}
