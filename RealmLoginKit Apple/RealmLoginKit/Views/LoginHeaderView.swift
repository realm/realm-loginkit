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

enum LoginHeaderViewStyle {
    case light
    case dark
}

class LoginHeaderView: UIView {

    public var style: LoginHeaderViewStyle = .light {
        didSet { applyTheme() }
    }

    public let realmLogoView = RealmLogoView(frame: CGRect.zero, style: .colored, wordMarkHidden: true)
    public let titleLabel = UILabel()

    private let viewHeight = 190 // Overall height of the view
    private let bottomMargin = 30 // Gap between the label and the bottom of the view
    private let logoSize = 100

    private var _isRegistering: Bool = false
    var isRegistering: Bool {
        set {
            setRegistering(newValue, animated: false)
        }
        
        get { return _isRegistering }
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
    
    //MARK: - View Management
    
    private func setUpViews() {
        realmLogoView.tintColor = .white
        realmLogoView.logoStrokeWidth = 3.0
        addSubview(realmLogoView)

        titleLabel.font = UIFont.systemFont(ofSize: 28.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(titleLabel)
        
        updateTitleView()
        applyTheme()
    }
    
    override func layoutSubviews() {
        var rect = CGRect.zero
        rect.size = CGSize(width: logoSize, height: logoSize)
        rect.origin.x = (bounds.size.width - CGFloat(logoSize)) * 0.5
        realmLogoView.frame = rect

        titleLabel.sizeToFit()
        rect = titleLabel.frame
        rect.origin.x = 15.0
        rect.size.width = bounds.size.width - 30.0
        rect.origin.y = bounds.size.height - CGFloat(bottomMargin + Int(rect.size.height))
        titleLabel.frame = rect
    }
    
    private func applyTheme() {
        let isDarkTheme = style == .dark
        titleLabel.textColor = isDarkTheme ? .white : .black
    }

    //MARK: Current State Management
    
    private func updateTitleView() {
        var titleName = appName
        if titleName == nil {
            titleName = "Realm Object Server"
        }
        
        if isRegistering {
            titleLabel.text = "Sign up for \(titleName!)"
        }
        else {
            titleLabel.text = "Log in to \(titleName!)"
        }
    }
    
    //MARK: Register State Transition
    
    func setRegistering(_ isRegistering: Bool, animated: Bool) {
        guard isRegistering != _isRegistering else {
            return
        }
        
        _isRegistering = isRegistering
        
        if animated == false {
            updateTitleView()
            return
        }

        UIView.transition(with: titleLabel, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.updateTitleView()
        }, completion: nil)
    }
}
