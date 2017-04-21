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
@testable import TORoundedTableView

class LoginDataSourceTests: XCTestCase {

    public var view: UIView?
    public var tableView: TORoundedTableView?
    public var dataSource: LoginTableViewDataSource?

    override func setUp() {
        super.setUp()

        // Create a container view and add the table view to it to implicitly trigger the layout code
        view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
        tableView = TORoundedTableView(frame: view!.bounds, style: .grouped)
        view!.addSubview(tableView!)

        dataSource = LoginTableViewDataSource()
        tableView!.dataSource = dataSource
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        tableView = nil
        dataSource = nil
    }

    func testHidingServerRow() {
        dataSource!.isServerURLFieldHidden = true
        XCTAssertTrue(tableView?.numberOfRows(inSection: 0) == 3)
    }

    func testHidingRememberDetailsRow() {
        dataSource!.isRememberAccountDetailsFieldHidden = true
        XCTAssertTrue(tableView?.numberOfRows(inSection: 0) == 3)
    }

    func testRegisteringState() {
        dataSource!.setRegistering(true, animated: false)
        XCTAssertTrue(tableView?.numberOfRows(inSection: 0) == 5)
    }

    func testRegisteringStateWithAllHidden() {
        dataSource!.isRememberAccountDetailsFieldHidden = true
        dataSource!.isServerURLFieldHidden = true
        dataSource!.setRegistering(true, animated: false)
        XCTAssertTrue(tableView?.numberOfRows(inSection: 0) == 3)
    }
}

