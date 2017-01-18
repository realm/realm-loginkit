//
//  LoginFooterView.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit

class LoginFooterView: UIView {

    private let viewHeight = 145 // Overall height of the view
    private let loginButtonHeight = 50
    private let loginButtonWidthScale = 0.8
    
    private let topMargin = 15
    private let middleMargin = 35
    
    private let loginButton = UIButton(type: .system)
    private let registerButton = UIButton(type: .system)
    
    var loginButtonTapped: (() -> Void)?
    var registerButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        var newRect = frame
        newRect.size.height = CGFloat(viewHeight)
        super.init(frame: newRect)
        setUpViews()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View Handling
    
    private func setUpViews() {
        loginButton.backgroundColor = UIColor(red: 0.941, green: 0.278, blue: 0.529, alpha: 1.0)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        addSubview(loginButton)
        
        let blueColor = UIColor(red: 0.219, green: 0.278, blue: 0.494, alpha: 1.0)
        
        registerButton.backgroundColor = .clear
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderColor = blueColor.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.masksToBounds = true
        registerButton.setTitleColor(blueColor, for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        registerButton.setTitle("Register a New Account", for: .normal)
        registerButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        addSubview(registerButton)
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rect = loginButton.frame
        rect.origin.y = CGFloat(topMargin)
        rect.size.width = bounds.size.width * CGFloat(loginButtonWidthScale)
        rect.size.height = CGFloat(loginButtonHeight)
        rect.origin.x = (bounds.size.width - rect.size.width) * 0.5
        loginButton.frame = rect
        
        registerButton.sizeToFit()
        rect = registerButton.frame
        rect.size.height = 44
        rect.size.width *= 1.2
        rect.origin.y = loginButton.frame.maxY + CGFloat(middleMargin)
        rect.origin.x = (bounds.size.width - rect.size.width) * 0.5
        registerButton.frame = rect
    }
    
    func buttonTapped(sender: AnyObject?) {
        guard let sender = sender else {
            return
        }
        
        if sender as! NSObject == loginButton {
            loginButtonTapped?()
        }
        else {
            registerButtonTapped?()
        }
    }
}
