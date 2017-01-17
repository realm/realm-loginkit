//
//  ViewController.swift
//  RealmLoginKit
//
//  Created by Tim Oliver on 1/16/17.
//  Copyright © 2017 Realm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loginViewController = LoginViewController()
        present(loginViewController, animated: false, completion: nil)
    }
}

