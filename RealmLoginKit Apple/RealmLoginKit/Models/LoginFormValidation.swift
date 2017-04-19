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

@objc public protocol LoginFormValidationProtocol {
    func isValidServerURL(_ serverURL: String?) -> Bool
    func isValidPortNumber(_ portNumber: Int) -> Bool
    func isValidUsername(_ username: String?) -> Bool
    func isValidPassword(_ password: String?) -> Bool
    func isPassword(_ password: String?, matching confirmPassword: String?) -> Bool
}

@objc(RLMLoginFormValidation)
public class LoginFormValidation: NSObject, LoginFormValidationProtocol {
    public func isValidServerURL(_ serverURL: String?) -> Bool {
        guard let serverURL = serverURL else { return false }
        return !serverURL.isEmpty
    }

    public func isValidPortNumber(_ portNumber: Int) -> Bool {
        return (0...65535 ~= portNumber)
    }

    public func isValidUsername(_ username: String?) -> Bool {
        guard let username = username else { return false }
        return !username.isEmpty
    }

    public func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        return !password.isEmpty
    }

    public func isPassword(_ password: String?, matching confirmPassword: String?) -> Bool {
        guard let password = password, let confirmPassword = confirmPassword else { return false }
        return password == confirmPassword
    }
}
