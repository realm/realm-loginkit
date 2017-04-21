//
//  RealmLoginKitExampleTests.swift
//  RealmLoginKitExampleTests
//
//  Created by Tim Oliver on 3/28/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import XCTest
@testable import RealmLoginKitExample

class RealmLoginKitViewControllerTests: XCTestCase {

    func testLoginControllerCreation() {
        let controller = LoginViewController()
        XCTAssertNotNil(controller.view)
    }

    func testLoginControllerUnsecureURLGeneration() {
        let controller = LoginViewController()
        controller.serverURL = "localhost"
        XCTAssertEqual(controller.authenticationRequestURL!.absoluteString, "http://localhost:9080")
    }

    func testLoginControllerSecureURLGeneration() {
        let controller = LoginViewController()
        controller.isSecureConnection = true
        controller.serverURL = "localhost"
        XCTAssertEqual(controller.authenticationRequestURL!.absoluteString, "https://localhost:9443")
    }

    func testLoginControllerURLGenerationPortNumber() {
        let controller = LoginViewController()
        controller.serverURL = "localhost"
        controller.serverPortNumber = 1337
        XCTAssertEqual(controller.authenticationRequestURL!.absoluteString, "http://localhost:1337")
    }
}
