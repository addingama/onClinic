//
//  ViewController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/8/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "userLoggedIn") == nil {
            print("user not logged in")
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            
            if (loginVC != nil) {
                self.navigationController?.present(loginVC, animated: true, completion: nil)
            }
        } else {
            print("userLoggedIn")
        }
    }


}

