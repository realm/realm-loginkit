//
//  RealmLoginKitExampleTests.swift
//  RealmLoginKitExampleTests
//
//  Created by Tim Oliver on 3/28/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import XCTest
@testable import RealmLoginKitExample

class RealmLoginKitExampleTests: XCTestCase {

    func testLoginControllerCreation() {
        let controller = LoginViewController()
        XCTAssertNotNil(controller.view)
    }
}
