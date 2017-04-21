//
//  LoginStringTests.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 4/20/17.
//  Copyright © 2017 Realm. All rights reserved.
//

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
