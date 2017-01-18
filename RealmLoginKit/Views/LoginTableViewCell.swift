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
    
    let textField = UITextField()
    var textChangedHandler: (() -> Void)?
    var returnButtonTappedHandler: (() -> Void)?
    
    //MARK: - Class Creation
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Text Field Setup
    
    func setUpViews() {
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        contentView.addSubview(textField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // The table cell's separatorInset property has only just been updated to the
        // final value at this point, so re-align the text field to match
        textField.frame = contentView.frame
        textField.frame.origin.x = separatorInset.left
        textField.frame.size.width -= separatorInset.left
    }
    
    //MARK: - Text Field Delegate
    @objc private func textFieldDidChange(_ sender: AnyObject?) {
        textChangedHandler?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnButtonTappedHandler?()
        return true
    }
}
