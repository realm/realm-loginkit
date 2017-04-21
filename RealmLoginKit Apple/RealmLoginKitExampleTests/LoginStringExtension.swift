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

class LoginStringExtensionTests: XCTestCase {
    
    public func testURLScheme() {
        XCTAssertEqual("http://www.test.com".URLScheme, "http")
        XCTAssertEqual("realm://www.test.com:9080".URLScheme, "realm")
        XCTAssertEqual("https://www.test.com:::9080".URLScheme, "https")
        XCTAssertEqual("realms://www.test.com:::9080".URLScheme, "realms")
        XCTAssertNil("192.168.1.1".URLScheme)
    }

    public func testURLPortNumber() {
        XCTAssertEqual("192.168.1.1".URLPortNumber, -1)
        XCTAssertEqual("192.168.1.1:9080".URLPortNumber, 9080)
        XCTAssertEqual("http://test.com:9080".URLPortNumber, 9080)
        XCTAssertEqual("http://test.com/:9080".URLPortNumber, 9080)
    }

    public func testURLHost() {
        XCTAssertEqual("192.168.1.1".URLHost, "192.168.1.1")
        XCTAssertEqual("192.168.1.1:9080".URLHost, "192.168.1.1")
        XCTAssertEqual("http://test.com:9080".URLHost, "test.com")
        XCTAssertEqual("test.com:9080".URLHost, "test.com")
    }
}
