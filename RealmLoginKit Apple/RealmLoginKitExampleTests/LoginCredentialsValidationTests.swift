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

import XCTest
@testable import RealmLoginKitExample
@testable import RealmLoginKit

class LoginCredentialsValidationTests: XCTestCase {
    
    func testLoginCredentialsServerURL() {
        let validation = LoginCredentialsValidation()
        XCTAssertTrue(validation.isValidServerURL("test.com"))
        XCTAssertTrue(validation.isValidServerURL("192.168.1.1"))
        XCTAssertFalse(validation.isValidServerURL(""))
        XCTAssertFalse(validation.isValidServerURL(nil))
    }

    func testLoginCredentialsPortNumber() {
        let validation = LoginCredentialsValidation()
        XCTAssertTrue(validation.isValidPortNumber(1337))
        XCTAssertTrue(validation.isValidPortNumber(9080))
        XCTAssertTrue(validation.isValidPortNumber(9443))
        XCTAssertFalse(validation.isValidPortNumber(-1))
        XCTAssertFalse(validation.isValidPortNumber(65536))
    }

    func testLoginCredentialsUsername() {
        let validation = LoginCredentialsValidation()
        XCTAssertTrue(validation.isValidUsername("to"))
        XCTAssertTrue(validation.isValidUsername("help@realm.io"))
        XCTAssertFalse(validation.isValidUsername(""))
        XCTAssertFalse(validation.isValidUsername(nil))
    }

    func testLoginCredentialsPassword() {
        let validation = LoginCredentialsValidation()
        XCTAssertTrue(validation.isValidPassword("password"))
        XCTAssertTrue(validation.isValidPassword("&#(!(#JSNCN#3617"))
        XCTAssertFalse(validation.isValidPassword(""))
        XCTAssertFalse(validation.isValidPassword(nil))
    }

    func testLoginCredentialsMatchingPassword() {
        let validation = LoginCredentialsValidation()
        XCTAssertTrue(validation.isPassword("password", matching: "password"))
        XCTAssertTrue(validation.isPassword("p4ssword!", matching: "p4ssword!"))
        XCTAssertFalse(validation.isPassword("password", matching: "PASSWORD"))
        XCTAssertFalse(validation.isPassword("password", matching: ""))
    }
}
