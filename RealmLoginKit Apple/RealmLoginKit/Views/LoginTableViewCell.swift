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
import TORoundedTableView

enum LoginTableViewCellType {
    case none
    case textField
    case toggleSwitch
}

class LoginTableViewCell: TORoundedTableViewCapCell, UITextFieldDelegate {
    
    /* Explicitly set the type of this cell so the appropriate views can be configured */
    public var type: LoginTableViewCellType = .textField {
        didSet {
            configureViews()
        }
    }
    
    // `lazy` wasn't flexible enough, so defer to old Objective-C style
    // lazy creation for now. (https://github.com/apple/swift-evolution/blob/master/proposals/0030-property-behavior-decls.md)
    private var _textField: UITextField? = nil
    public var textField: UITextField? {
        return _textField
    }
    
    private var _switch: UISwitch? = nil
    public var `switch`: UISwitch? {
        return _switch
    }
    
    var textChangedHandler: (() -> Void)?
    var returnButtonTappedHandler: (() -> Void)?
    var switchChangedHandler: (() -> Void)?
    
    //MARK: - Class Creation
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Setup
    
    func configureViews() {
        if type == .textField && _textField == nil {
            _textField = UITextField()
            _textField?.autocorrectionType = .no
            _textField?.autocapitalizationType = .none
            _textField?.delegate = self
            _textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            contentView.addSubview(_textField!)
        }
        
        if type == .toggleSwitch && _switch == nil {
            _switch = UISwitch()
            _switch?.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
            contentView.addSubview(_switch!)
        }
        
        _textField?.isHidden = type != .textField
        _switch?.isHidden = type != .toggleSwitch
        
        setNeedsLayout()
    }

    //MARK: - View Management
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // The table cell's separatorInset property has only just been updated to the
        // final value at this point, so re-align the text field to match
        if let _textField = _textField {
            _textField.frame = contentView.frame
            _textField.frame.origin.x = separatorInset.left
            _textField.frame.size.width -= separatorInset.left
        }

        if let _switch = _switch {
            _switch.frame.origin.x = (contentView.bounds.width - _switch.frame.width) - 20
            _switch.frame.origin.y = (contentView.bounds.midY - _switch.bounds.midY)
        }
    }
    
    //MARK: - Switch Delegate
    
    @objc private func switchDidChange(_ sender: AnyObject?) {
        switchChangedHandler?()
    }
    
    //MARK: - Text Field Delegate
    
    @objc private func textFieldDidChange(_ sender: AnyObject?) {
        textChangedHandler?()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnButtonTappedHandler?()
        return true
    }
    
    //MARK: - Class Clean Up
    
    override func prepareForReuse() {
        switchChangedHandler = nil
        textChangedHandler = nil
        returnButtonTappedHandler = nil
        
        textLabel?.text = nil
        
        _textField?.keyboardType = .default
        _textField?.isSecureTextEntry = false
        _textField?.returnKeyType = .next
    }
}
