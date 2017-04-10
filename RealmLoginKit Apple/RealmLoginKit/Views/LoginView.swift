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

class LoginView: UIView {

    /* Subviews */
    public let containerView = UIView()
    public let navigationBar = UINavigationBar()
    public let tableView     = TORoundedTableView()
    public let headerView    = LoginHeaderView()
    public let footerView    = LoginFooterView()
    public let copyrightView = UILabel()
    public var closeButton: UIButton? = nil

    public var effectView: UIVisualEffectView?
    public var backgroundView: UIView?

    // MARK: - View Creation -

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpTranslucentViews() {
        effectView = UIVisualEffectView()
        //effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        effectView?.frame = view.bounds
        effectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(effectView!)
    }

    private func setUpTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.maximumWidth = 500
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.delaysContentTouches = false
        containerView.addSubview(tableView)

        let infoDictionary = Bundle.main.infoDictionary!
        if let displayName = infoDictionary["CFBundleDisplayName"] {
            headerView.appName = displayName as? String
        }
        else if let displayName = infoDictionary[kCFBundleNameKey as String] {
            headerView.appName = displayName as? String
        }

        footerView.loginButtonTapped = {
            self.submitLogin()
        }

        footerView.registerButtonTapped = {
            self.setRegistering(!self.isRegistering, animated: true)
        }
    }

    private func setUpCloseButton() {
        //Check if we're already set up
//        if isCancelButtonHidden && closeButton == nil { return }
//        if !isCancelButtonHidden && closeButton != nil { return }
//
//        if isCancelButtonHidden {
//            closeButton?.removeFromSuperview()
//            closeButton = nil
//            return
//        }

        let closeIcon = UIImage.closeIcon()
        closeButton = UIButton(type: .system)
        closeButton?.setImage(closeIcon, for: .normal)
        closeButton?.frame = CGRect(origin: .zero, size: closeIcon.size)
        closeButton?.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        self.addSubview(closeButton!)
    }

    private func setUpCommonViews() {
        backgroundView = UIView()
        backgroundView?.frame = view.bounds
        backgroundView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(backgroundView!)

        containerView.frame = view.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(containerView)

        navigationBar.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 20)
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.alpha = 0.0
        self.addSubview(navigationBar)

        copyrightView.text = "With ❤️ from the Realm team, 2017."
        copyrightView.textAlignment = .center
        copyrightView.font = UIFont.systemFont(ofSize: 15)
        copyrightView.sizeToFit()
        copyrightView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        copyrightView.frame.origin.y = self.bounds.height - copyrightViewMargin
        copyrightView.frame.origin.x = (self.bounds.width - copyrightView.frame.width) * 0.5
        containerView.addSubview(copyrightView)

        setUpTableView()
        setUpCloseButton()
        
        applyTheme()
    }

}
