//
//  LoginTableViewDataSource.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 4/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit

/* The types of inputs cells may be */
public enum LoginViewControllerCellType: Int {
    case serverURL
    case email
    case password
    case confirmPassword
    case rememberLogin
}

class LoginTableViewDataSource: NSObject, UITableViewDataSource {

    /** The table view managed by this data source */
    public var tableView: UITableView?

    /** Sets whether to show the Realm server URL or not */
    public var isServerURLFieldHidden = false {
        didSet { tableView?.reloadData() }
    }

    /** Sets whether the 'Remember these Details' field is visible. */
    public var isRememberAccountDetailsFieldHidden: Bool = false {
        didSet { tableView?.reloadData() }
    }

    /* Login Credentials */
    public var serverURL = ""
    public var userName = ""
    public var password = ""
    public var confirmPassword = ""
    public var rememberLogin = true

    public var isRegistering: Bool {
        get { return _isRegistering }
        set { setRegistering(newValue, animated: false) }
    }

    //MARK: - Private Properties -

    private var _isRegistering = false

    /* Assets */
    private let earthIcon = UIImage.earthIcon()
    private let lockIcon  = UIImage.lockIcon()
    private let mailIcon  = UIImage.mailIcon()
    private let tickIcon  = UIImage.tickIcon()

    //MARK: - Table View Data Source -

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = isRegistering ? 5 : 4
        if isServerURLFieldHidden { numberOfRows -= 1 }
        if isRememberAccountDetailsFieldHidden { numberOfRows -= 1 }
        return numberOfRows
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LoginTableViewCell
        if cell == nil {
            cell = LoginTableViewCell(style: .default, reuseIdentifier: identifier)
        }

        let lastCellIndex = tableView.numberOfRows(inSection: 0) - 1

        // Configure rounded caps
        cell?.topCornersRounded    = (indexPath.row == 0)
        cell?.bottomCornersRounded = (indexPath.row == lastCellIndex)

        // Configure cell content
        switch cellType(for: indexPath.row) {
        case .serverURL:
            cell?.type = .textField
            cell?.imageView?.image = earthIcon
            cell?.textField?.placeholder = "Server URL"
            cell?.textField?.text = serverURL
            cell?.textField?.keyboardType = .URL
            cell?.textChangedHandler = { self.serverURL = cell?.textField?.text }
            cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: indexPath.row + 1) }
        case .email:
            cell?.type = .textField
            cell?.imageView?.image = mailIcon
            cell?.textField?.placeholder = "Username"
            cell?.textField?.text = username
            cell?.textField?.keyboardType = .emailAddress
            cell?.textChangedHandler = { self.username = cell?.textField?.text }
            cell?.returnButtonTappedHandler = { self.makeFirstResponder(atRow: indexPath.row + 1) }
        case .password:
            cell?.type = .textField
            cell?.imageView?.image = lockIcon
            cell?.textField?.placeholder = "Password"
            cell?.textField?.text = password
            cell?.textField?.isSecureTextEntry = true
            cell?.textField?.returnKeyType = isRegistering ? .next : .done
            cell?.textChangedHandler = { self.password = cell?.textField?.text }
            cell?.returnButtonTappedHandler = {
                if self.isRegistering { self.makeFirstResponder(atRow: indexPath.row + 1) }
                else { self.submitLogin() }
            }
        case .confirmPassword:
            cell?.type = .textField
            cell?.imageView?.image = lockIcon
            cell?.textField?.placeholder = "Confirm Password"
            cell?.textField?.text = confirmPassword
            cell?.textField?.isSecureTextEntry = true
            cell?.textField?.returnKeyType = .done
            cell?.textChangedHandler = { self.confirmPassword = cell?.textField?.text }
            cell?.returnButtonTappedHandler = { self.submitLogin() }
        case .rememberLogin:
            cell?.type = .toggleSwitch
            cell?.imageView?.image = tickIcon
            cell?.textLabel!.text = "Remember My Account"
            cell?.switch?.isOn = rememberLogin
            cell?.switchChangedHandler = { self.rememberLogin = (cell?.switch?.isOn)! }
        }

        // Apply the theme after all cell configuration is done
        applyTheme(to: cell!)

        return cell!
    }

    private func cellType(for rowIndex: Int) -> LoginViewControllerCellType {
        switch rowIndex {
        case 0: return isServerURLFieldHidden ? .email : .serverURL
        case 1: return isServerURLFieldHidden ? .password : .email
        case 2:
            if isServerURLFieldHidden && !isRegistering {
                return .rememberLogin
            }
            else if isRegistering && isServerURLFieldHidden {
                return .confirmPassword
            }
            else {
                return .password
            }
        case 3:
            if isRegistering && !isServerURLFieldHidden {
                return .confirmPassword
            }
            else {
                return .rememberLogin
            }
        case 4: return .rememberLogin
        default: return .email
        }

    }

    // MARK: - Login/Register Transition

    func setRegistering(_ isRegistering: Bool, animated: Bool) {
        guard _isRegistering != isRegistering else {
            return
        }

        _isRegistering = isRegistering

        let rowIndex = isServerURLFieldHidden ? 2 : 3

        // Insert/Delete the 'confirm password' field
        if _isRegistering {
            tableView?.insertRows(at: [IndexPath(row: rowIndex, section: 0)], with: animated ? .fade : .none)
            tableView?.reloadRows(at: [IndexPath(row: rowIndex - 1, section: 0)], with: .none)
        }
        else {
            tableView?.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: animated ? .fade : .none)
            tableView?.reloadRows(at: [IndexPath(row: rowIndex - 1, section: 0)], with: .none)
        }
    }

    // MARK: - Keyboard Handling
    func makeFirstResponder(atRow row: Int) {
        let cell = tableView?.cellForRow(at: IndexPath(row: row, section: 0)) as! LoginTableViewCell
        cell.textField?.becomeFirstResponder()
    }
}
