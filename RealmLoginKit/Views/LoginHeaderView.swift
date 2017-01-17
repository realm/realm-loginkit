//
//  LoginHeaderView.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit

class LoginHeaderView: UIView {

    private let viewHeight = 210 // Overall height of the view
    private let bottomMargin = 40 // Gap between the label and the bottom of the view
    
    private let logoSize = 100
    
    private var _registering: Bool = false
    
    let realmLogoView = RealmLogoView(frame: CGRect.zero, style: .colored, wordMarkHidden: true)
    let titleLabel = UILabel()
    
    var registering: Bool {
        set {
            _registering = newValue
        }
        
        get { return _registering }
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
        titleLabel.text = "Log Into Realm Tasks"
        addSubview(titleLabel)
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

    func setRegistering(_ registering: Bool, animated: Bool) {
        
    }
}
