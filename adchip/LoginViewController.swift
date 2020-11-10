//
//  LoginViewController.swift
//  adchip
//
//  Created by 野中志保 on 2020/08/27.
//  Copyright © 2020 野中志保. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    private var twitterProvider : OAuthProvider?
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapLoginButton(_ sender: Any) {
        twitterProvider = OAuthProvider(providerID:"twitter.com")
        twitterProvider?.getCredentialWith(_: nil){ [weak self] (credential, error) in
            guard let weakSelf = self else { return }
            guard let credential = credential, error == nil else { return }
            Auth.auth().signInAndRetrieveData(with: credential, completion: { (authResult, error) in
                guard error == nil else { return }
                if authResult != nil {
                    // 画面遷移
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeVC = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
                    weakSelf.present(homeVC, animated: true, completion: nil)
                }
            })
        }
    }
    
    
}

