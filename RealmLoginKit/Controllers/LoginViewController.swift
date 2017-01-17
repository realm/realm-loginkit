//
//  LoginViewController.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/17/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit
import TORoundedTableView

enum LoginViewControllerStyle {
    case lightTranslucent
    case lightOpaque
    case darkTranslucent
    case darkOpaque
}

class LoginViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Public Properties
    
    /** 
     The visual style of the login controller
    */
    var style = LoginViewControllerStyle.lightTranslucent
    
    //MARK: - Private Properties
    
    /* Assets */
    private let lockIcon = UIImage.lockIcon()
    private let mailIcon = UIImage.mailIcon()
    
    /* Views */
    private let navigationBar = UINavigationBar()
    private let tableView = TORoundedTableView()
    private let headerView = LoginHeaderView()
    private let footerView = LoginFooterView()
    private var effectView: UIVisualEffectView?
    private var dimmingView: UIView?
    
    /* State Convienience Methods */
    private var isTranslucent: Bool  {
        return style == .lightTranslucent || style == .darkTranslucent
    }
    
    private var isDarkStyle: Bool {
        return style == .darkTranslucent || style == .darkOpaque
    }
    
    //MARK: - Class Creation
    
    init(style: LoginViewControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        
        modalPresentationStyle = isTranslucent ? .overFullScreen : .fullScreen
    }
    
    convenience init() {
        self.init(style: .lightTranslucent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - View Setup
    
    private func setUpTranslucentViews() {
        effectView = UIVisualEffectView()
        effectView?.effect = UIBlurEffect(style: isDarkStyle ? .dark : .light)
        effectView?.frame = view.bounds
        effectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(effectView!)
        
        dimmingView = UIView()
        dimmingView?.frame = view.bounds
        dimmingView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView?.backgroundColor = UIColor(white: 0.9, alpha: 0.3)
        view.addSubview(dimmingView!)
    }
    
    private func setUpCommonViews() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.maximumWidth = 500
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.delaysContentTouches = false
        view.addSubview(tableView)
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 20)
        navigationBar.autoresizingMask = [.flexibleWidth]
        navigationBar.alpha = 0.0
        view.addSubview(navigationBar)
    }
    
    //MARK: - View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        if isTranslucent {
            setUpTranslucentViews()
        }
        
        setUpCommonViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Vertically align the table view content in the middle of the view
        let contentSize = tableView.contentSize
        let boundsHeight = view.bounds.size.height
        let verticalPadding = max((boundsHeight - contentSize.height) * 0.5, 0)
        
        print(verticalPadding)
        
        var edgeInsets = tableView.contentInset
        edgeInsets.top = verticalPadding
        edgeInsets.bottom = verticalPadding
        tableView.contentInset = edgeInsets
    }
    
    //MARK: - Scroll View Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if UIApplication.shared.isStatusBarHidden {
            navigationBar.alpha = 0.0
            return
        }
        
        let statusBarFrameHeight = UIApplication.shared.statusBarFrame.height
        navigationBar.frame.size.height = statusBarFrameHeight
        
        // Show the navigation bar when content starts passing under the status bar
        let verticalOffset = scrollView.contentOffset.y
        
        if verticalOffset >= -statusBarFrameHeight {
            navigationBar.alpha = 1.0
        }
        else if verticalOffset <= -(statusBarFrameHeight + 20) {
            navigationBar.alpha = 0.0
        }
        else {
            navigationBar.alpha = 1.0 - ((abs(verticalOffset) - 20) / statusBarFrameHeight)
        }
    }
    
    //MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CapCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = TORoundedTableViewCapCell(style: .default, reuseIdentifier: identifier)
            cell?.imageView?.tintColor = UIColor(white: 0.6, alpha: 1.0)
            cell?.selectionStyle = .none
        }
        
        let capCell = (cell as! TORoundedTableViewCapCell)
        
        capCell.topCornersRounded = (indexPath.row == 0)
        capCell.bottomCornersRounded = (indexPath.row == 1)
        
        capCell.imageView?.image = (indexPath.row == 0 ? mailIcon : lockIcon)
        capCell.textLabel?.text = (indexPath.row == 0) ? "to@realm.io" : "p@ssword"
        
        return capCell
    }
}
