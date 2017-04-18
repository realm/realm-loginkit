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

    public var canRegisterNewAccounts = true {
        didSet {
            footerView.isRegisterButtonHidden = !canRegisterNewAccounts
            tableView.reloadData()
        }
    }

    public var isCancelButtonHidden = true {
        didSet {
            setUpCloseButton()
        }
    }

    /* Closure called when the user taps the 'Close' button */
    public var didTapCloseHandler: (() ->())?

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

    public var isDarkStyle = false
    public var isTranslucentStyle = true

    /* Layout Constants */
    private let copyrightViewMargin: CGFloat = 45
    private let closeButtonInset = UIEdgeInsets(top: 15, left: 18, bottom: 0, right: 0)

    // MARK: - View Creation -

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(darkStyle: Bool, translucentStyle: Bool) {
        super.init(frame: CGRect.zero)
        self.isDarkStyle = darkStyle
        self.isTranslucentStyle = translucentStyle
        setUpAllViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpAllViews() {
        
    }

    private func setUpTranslucentViews() {
        effectView = UIVisualEffectView()
        effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        effectView?.frame = bounds
        effectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(effectView!)
    }

    private func setUpTableView() {
        tableView.frame = bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
    }

    private func setUpCloseButton() {
        //Check if we're already set up
        if isCancelButtonHidden && closeButton == nil { return }
        if !isCancelButtonHidden && closeButton != nil { return }

        if isCancelButtonHidden {
            closeButton?.removeFromSuperview()
            closeButton = nil
            return
        }

        let closeIcon = UIImage.closeIcon()
        closeButton = UIButton(type: .system)
        closeButton?.setImage(closeIcon, for: .normal)
        closeButton?.frame = CGRect(origin: .zero, size: closeIcon.size)
        closeButton?.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        self.addSubview(closeButton!)
    }

    private func setUpCommonViews() {
        backgroundView = UIView()
        backgroundView?.frame = bounds
        backgroundView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(backgroundView!)

        containerView.frame = bounds
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

    private func applyTheme() {
        // view accessory views
        navigationBar.barStyle  = isDarkStyle ? .blackTranslucent : .default
        copyrightView.textColor = isDarkStyle ? UIColor(white: 0.3, alpha: 1.0) : UIColor(white: 0.6, alpha: 1.0)

        // view background
        if isTranslucent {
            backgroundView?.backgroundColor = UIColor(white: isDarkStyle ? 0.1 : 0.9, alpha: 0.3)
        }
        else {
            backgroundView?.backgroundColor = UIColor(white: isDarkStyle ? 0.15 : 0.95, alpha: 1.0)
        }

        if effectView != nil {
            effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        }

        if closeButton != nil {
            let greyShade = isDarkStyle ? 1.0 : 0.2
            closeButton?.tintColor = UIColor(white: CGFloat(greyShade), alpha: 1.0)
        }

        // table accessory views
        headerView.style = isDarkStyle ? .dark : .light
        footerView.style = isDarkStyle ? .dark : .light

        // table view and cells
        tableView.separatorColor = isDarkStyle ? UIColor(white: 0.4, alpha: 1.0) : nil
        tableView.cellBackgroundColor = UIColor(white: isDarkStyle ? 0.2 : 1.0, alpha: 1.0)
    }

    // MARK: - View Layout -

    public func layoutTableContentInset() {

        // Vertically align the table view so the table cells are in the middle
        let boundsHeight = view.bounds.size.height - keyboardHeight // Adjusted for keyboard visibility
        let contentHeight = tableView.contentSize.height
        let sectionHeight = tableView.rect(forSection: 0).size.height
        let contentMidPoint: CGFloat //

        // If keyboard is not visible, align the table cells to the middle of the screen,
        // else just align the whole content region
        if keyboardHeight > 0 {
            contentMidPoint = contentHeight * 0.5
        }
        else {
            contentMidPoint = headerView.frame.height + (sectionHeight * 0.5)
        }

        var topPadding    = max(0, (boundsHeight * 0.5) - contentMidPoint)
        topPadding += (UIApplication.shared.statusBarFrame.height + 10)

        var bottomPadding:CGFloat = 0.0
        if keyboardHeight > 0 {
            bottomPadding = keyboardHeight + 15
        }

        var edgeInsets = tableView.contentInset
        edgeInsets.top = topPadding
        edgeInsets.bottom = bottomPadding
        tableView.contentInset = edgeInsets
    }

    public func layoutNavigationBar() {
        if UIApplication.shared.isStatusBarHidden {
            navigationBar.alpha = 0.0
            return
        }

        let statusBarFrameHeight = UIApplication.shared.statusBarFrame.height
        navigationBar.frame.size.height = statusBarFrameHeight

        // Show the navigation bar when content starts passing under the status bar
        let verticalOffset = self.tableView.contentOffset.y

        if verticalOffset >= -statusBarFrameHeight {
            navigationBar.alpha = 1.0
        }
        else if verticalOffset <= -(statusBarFrameHeight + 10) {
            navigationBar.alpha = 0.0
        }
        else {
            navigationBar.alpha = 1.0 - ((abs(verticalOffset) - statusBarFrameHeight) / 10.0)
        }
    }

    public func updateCopyrightViewVisibility() {
        // Hide the copyright if there's not enough vertical space on the screen for it to not
        // interfere with the rest of the content
        let isHidden = (tableView.contentInset.top + tableView.contentSize.height) > copyrightView.frame.minY
        copyrightView.alpha = isHidden ? 0.0 : 1.0
    }

    public func updateCloseButtonVisibility() {
        guard let closeButton = self.closeButton else {
            return
        }

        guard self.traitCollection.horizontalSizeClass == .compact else {
            closeButton.alpha = 1.0
            return
        }

        let titleLabel = self.headerView.titleLabel
        let yOffset = titleLabel.frame.origin.y - tableView.contentOffset.y
        let thresholdY = closeButton.frame.maxY
        let normalizedOffset = yOffset - thresholdY
        var alpha = normalizedOffset / 30.0
        alpha = min(1.0, alpha); alpha = max(0.0, alpha)
        closeButton.alpha = alpha
    }

    public func layoutCopyrightView() {
        guard copyrightView.isHidden == false else {
            return
        }

        // Offset the copyright label
        let verticalOffset = tableView.contentOffset.y
        let normalizedOffset = verticalOffset + tableView.contentInset.top
        copyrightView.frame.origin.y = (view.bounds.height - copyrightViewMargin) - normalizedOffset
    }

    public func layoutCloseButton() {
        guard let closeButton = self.closeButton else {
            return
        }

        let statusBarFrame = UIApplication.shared.statusBarFrame

        var rect = closeButton.frame
        rect.origin.x = closeButtonInset.left
        rect.origin.y = statusBarFrame.size.height + closeButtonInset.top
        closeButton.frame = rect
    }

    //MARK: - Interactions -
    @objc private func didTapCloseButton(sender: AnyObject?) {
        didTapCloseHandler?()
    }
}
