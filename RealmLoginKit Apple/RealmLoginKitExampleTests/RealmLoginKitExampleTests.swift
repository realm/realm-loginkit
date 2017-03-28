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

    func testExample() {
        let controller = LoginViewController()
        XCTAssertNotNil(controller)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
