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
import AWSCore
import AWSCognitoIdentityProvider

class AWSCognitoAuthenticationProvider: NSObject, AuthenticationProvider, AWSCognitoIdentityInteractiveAuthenticationDelegate {

    public var userName: String? = nil
    public var password: String? = nil
    public var signingUp: Bool = false

    // AWS Account Credentials
    private let serviceRegion: AWSRegionType
    private let userPoolID: String
    private let clientID: String

    private let userPool: AWSCognitoIdentityUserPool

    public var shouldExposeURL: Bool { return false }

    init(serviceRegion: AWSRegionType, userPoolID: String, clientID: String, clientSecret: String) {
        self.serviceRegion = serviceRegion
        self.userPoolID = userPoolID
        self.clientID = clientID

        let serviceConfiguration = AWSServiceConfiguration(region: self.serviceRegion, credentialsProvider: nil)
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: self.clientID, clientSecret: clientSecret, poolId: self.userPoolID)

        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration:poolConfiguration, forKey:"RealmLoginKit")
        self.userPool = AWSCognitoIdentityUserPool(forKey: "RealmLoginKit")

        super.init()
        
        self.userPool.delegate = self
    }

    func authenticate(success: ((RLMSyncCredentials) -> Void)?, error: ((Error) -> Void)?) {
        if self.signingUp {
            let attributes = [AWSCognitoIdentityUserAttributeType(name: "email", value: userName!)]
            self.userPool.signUp(userName!, password: password!, userAttributes: attributes, validationData: nil).continueWith(block: { task -> Any? in
                DispatchQueue.main.async {
                    if (task.error != nil) {
                        error?(task.error!)
                        return
                    }

                    let response = task.result!
                    response.user.getSession().continueWith(block: { task -> Any? in
                        DispatchQueue.main.async {
                            if (task.error != nil) {
                                error?(task.error!)
                                return
                            }

                            let session = task.result!
                            print("Access token is \(session.accessToken!)")
                        }
                        return nil
                    })
                }

                return nil
            })
        }
        else {
            let user = self.userPool.getUser(userName!)
            user.getSession(userName!, password: password!, validationData: nil).continueWith(block: { task -> Any? in
                DispatchQueue.main.async {
                    if (task.error != nil) {
                        error?(task.error!)
                        return
                    }

                    let userSession = task.result!
                    let credentials = RLMSyncCredentials(customToken: userSession.accessToken!.tokenString, provider: RLMIdentityProvider(rawValue: "fooauth"), userInfo: nil)
                    success?(credentials)
                }

                return nil
            })
        }
    }

    func cancelAuthentication() -> Bool {
        return true
    }
}
