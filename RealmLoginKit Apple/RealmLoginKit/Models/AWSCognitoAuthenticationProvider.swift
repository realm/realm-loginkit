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

class AWSCognitoAuthenticationProvider: NSObject, AuthenticationProvider {

    public var userName: String? = nil
    public var password: String? = nil
    public var signingUp: Bool = false

    // AWS Account Credentials
    private let serviceRegion: AWSRegionType
    private let userPoolID: String
    private let clientID: String

    public var shouldExposeURL: Bool { return false }

    private var userPool: AWSCognitoIdentityUserPool? = nil

    init(serviceRegion: AWSRegionType, userPoolID: String, clientID: String) {
        self.serviceRegion = serviceRegion
        self.userPoolID = userPoolID
        self.clientID = clientID
    }

    func authenticate(success: (RLMSyncCredentials) -> Void, error: (Error) -> Void) {
        let serviceConfiguration = AWSServiceConfiguration(region: self.serviceRegion, credentialsProvider: nil)
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: self.clientID, clientSecret: "SECRET", poolId: self.userPoolID)

        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration:poolConfiguration, forKey:"UserPool")
        userPool = AWSCognitoIdentityUserPool(forKey: "UserPool")

        if self.signingUp {
            let user = userPool!.signUp(userName!, password: password!, userAttributes: nil, validationData: nil)
            print(user)
        }
    }

    func cancelAuthentication() -> Bool {
        return true
    }
}
