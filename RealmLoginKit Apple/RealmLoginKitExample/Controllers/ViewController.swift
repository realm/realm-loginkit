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

class ViewController: UIViewController {

    let segmentedControl = UISegmentedControl(items: ["Light", "Dark"])
    @IBOutlet var realmLogoView: RealmLogoView?
    
    var isDarkMode: Bool {
        return segmentedControl.selectedSegmentIndex == 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        realmLogoView?.logoStrokeWidth = 8.0
        realmLogoView?.tintColor = .white
        
        segmentedControl.frame.size.width = 200
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func segmentedControlChanged() {
        view.backgroundColor = UIColor(white: isDarkMode ? 0.1 : 0.92, alpha: 1.0)
        navigationController?.navigationBar.barStyle = isDarkMode ? .blackTranslucent : .default
        view.window?.tintColor = isDarkMode ? UIColor(red:90.0/255.0, green:120.0/255.0, blue:218.0/255.0, alpha:1.0) : nil;
        realmLogoView?.style = isDarkMode ? .monochrome : .colored
    }
    
    @IBAction func showLoginButtonTapped(_ sender: AnyObject?) {
        let style: LoginViewControllerStyle = isDarkMode ? .darkTranslucent : .lightTranslucent
        let loginViewController = LoginViewController(style: style)
        loginViewController.authenticationProvider = AWSCognitoAuthenticationProvider(serviceRegion: .USEast1, userPoolID: "", clientID: "")
        loginViewController.isCancelButtonHidden = false
        loginViewController.loginSuccessfulHandler = { user in
            loginViewController.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        present(loginViewController, animated: true, completion: nil)
    }
}

