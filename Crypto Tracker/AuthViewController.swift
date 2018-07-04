//
//  AuthViewController.swift
//  Crypto Tracker
//
//  Created by Edward White on 7/4/18.
//  Copyright © 2018 Edward White. All rights reserved.
//

import UIKit
import LocalAuthentication
class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        presentAuth()
        // Do any additional setup after loading the view.
    }
    func presentAuth() {
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Your crypto is protected by biometrics") {(success, error) in
            if success {
                DispatchQueue.main.async {

                    let cryptoTableVC = CryptoTableViewController()
                    let navController = UINavigationController(rootViewController: cryptoTableVC)
                    self.present(navController, animated: true, completion: nil)
                }
            } else {
                self.presentAuth()
            }
        }
    }

}
