//
//  LoginTableViewCell.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/18/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit
import TORoundedTableView

class LoginTableViewCell: TORoundedTableViewCapCell, UITextFieldDelegate {
    
    // `lazy` wasn't flexible enough, so defer to old Objective-C style
    // lazy creation for now. (https://github.com/apple/swift-evolution/blob/master/proposals/0030-property-behavior-decls.md)
    private var _textField: UITextField? = nil
    public var textField: UITextField {
        setUpTextField()
        return _textField!
    }
    
    private var _switch: UISwitch? = nil
    public var `switch`: UISwitch {
        setUpSwitch()
        return _switch!
    }
    
    var textChangedHandler: (() -> Void)? {
        didSet {
            if textChangedHandler != nil { setUpTextField() }
        }
    }
    
    var returnButtonTappedHandler: (() -> Void)? {
        didSet {
            if returnButtonTappedHandler != nil { setUpTextField() }
        }
    }
    
    var switchChangedHandler: (() -> Void)? {
        didSet {
            if switchChangedHandler != nil { setUpSwitch() }
        }
    }
    
    //MARK: - Class Creation
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Setup
    
    func setUpTextField() {
        guard _textField == nil else { return }
    
        _textField = UITextField()
        _textField?.autocorrectionType = .no
        _textField?.autocapitalizationType = .none
        _textField?.delegate = self
        _textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        contentView.addSubview(_textField!)
        setNeedsLayout()
    }
    
    func setUpSwitch() {
        guard _switch == nil else { return }
        
        _switch = UISwitch()
        _switch?.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        contentView.addSubview(_switch!)
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
