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

class LoginPersistedCredentialsCoordinator: NSObject {

    //MARK: - Public Properties -
    public var numberOfSavedCrendentialObjects: UInt {
        guard realmFileExists else { return 0 }
        return LoginCredential.allObjects(in: credentialsRealm).count
    }

    //MARK: - Private Realm Setup Properties -

    /** The name of the Realm file that will hold all of the credentials */
    let realmFileName = "io.realm.loginkit.credentials.realm"

    /** The file path to where the credentials file is saved. Placed in the 'Application Support' directory. */
    lazy var realmFileURL: URL = {
        return FileManager.default.applicationSupportDirectoryURL.appendingPathComponent(self.realmFileName)
    }()

    /** Generates the Realm configuration object that will manage this credentials Realm. */
    lazy var credentialsRealmConfiguration: RLMRealmConfiguration = {
        let configuration = RLMRealmConfiguration.default()
        configuration.fileURL = self.realmFileURL
        configuration.objectClasses = [LoginCredentialList.self, LoginCredential.self]
        configuration.encryptionKey = LoginPersistedCredentialsCoordinator.getEncryptionKey()
        return configuration
    }()

    /** Checks if Realm has created the credentials file on disk yet. */
    private var realmFileExists: Bool {
        return FileManager.default.fileExists(atPath: realmFileURL.path)
    }

    /** Create a new instance of the credentials Realm */
    private var credentialsRealm: RLMRealm {
        return try! RLMRealm(configuration: credentialsRealmConfiguration)
    }

    // MARK: - Security Keychain Interaction -

    private class func getEncryptionKey() -> Data {
        // Identifier for our keychain entry - should be unique for your application
        let keychainIdentifier = "io.realm.loginkit.credentials"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        // First check in the keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]

        // To avoid Swift optimization bug, should use withUnsafeMutablePointer() function to retrieve the keychain item
        // See also: http://stackoverflow.com/questions/24145838/querying-ios-keychain-using-swift/27721328#27721328
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as! Data
        }

        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")

        // Store the key in the keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: keyData
        ]

        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")

        return keyData as Data
    }
}
