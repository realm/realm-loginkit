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

class LoginCredentialsList: RLMObject {
    @objc dynamic var credentialsList = RLMArray<LoginCredentials>(objectClassName: LoginCredentials.className())

    override class func shouldIncludeInDefaultSchema() -> Bool {
        return false
    }
}

class LoginCredentials: RLMObject {
    @objc dynamic var serverURL: String?
    @objc dynamic var username: String?
    @objc dynamic var password: String?

    override class func indexedProperties() -> [String] {
        return ["serverURL", "username"]
    }

    override class func shouldIncludeInDefaultSchema() -> Bool {
        return false
    }
}
