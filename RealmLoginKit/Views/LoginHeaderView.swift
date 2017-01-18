//
//  LoginHeaderView.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit

enum LoginHeaderViewStyle {
    case light
    case dark
}

class LoginHeaderView: UIView {

    private let viewHeight = 190 // Overall height of the view
    private let bottomMargin = 30 // Gap between the label and the bottom of the view
    
    private let logoSize = 100
    
    private let realmLogoView = RealmLogoView(frame: CGRect.zero, style: .colored, wordMarkHidden: true)
    private let titleLabel = UILabel()
    
    private var _registering: Bool = false
    var isRegistering: Bool {
        set {
            setRegistering(newValue, animated: false)
        }
        
        get { return _registering }
    }
    
    public var appName: String? {
        didSet {
            updateTitleView()
        }
    }
    
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
    
    private func setUpViews() {
        addSubview(realmLogoView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 28.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        addSubview(titleLabel)
        
        updateTitleView()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        rect.size = CGSize(width: logoSize, height: logoSize)
        rect.origin.x = (bounds.size.width - CGFloat(logoSize)) * 0.5
        realmLogoView.frame = rect
        
        titleLabel.sizeToFit()
        rect = titleLabel.frame
        rect.origin.x = 0.0
        rect.size.width = bounds.size.width
        rect.origin.y = bounds.size.height - CGFloat(bottomMargin + Int(rect.size.height))
        titleLabel.frame = rect
    }

    private func updateTitleView() {
        var titleName = appName
        if titleName == nil {
            titleName = "Realm Object Server"
        }
        
        if isRegistering {
            titleLabel.text = "Sign Up for \(titleName!)"
        }
        else {
            titleLabel.text = "Log Into \(titleName!)"
        }
    }
    
    func setRegistering(_ registering: Bool, animated: Bool) {
        guard registering != _registering else {
            return
        }
        
        _registering = registering
        
        if animated == false {
            updateTitleView()
            return
        }

        UIView.transition(with: titleLabel, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.updateTitleView()
        }, completion: nil)
    }
}
