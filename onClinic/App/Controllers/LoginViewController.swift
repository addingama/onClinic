//
//  LoginController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/8/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        let username = tfUsername.text
        let password = tfPassword.text
        
        print("Username: \(username) \nPassword: \(password)")
    }
    
    
    @IBAction func btnRegister(_ sender: UIButton) {
    }
    
}
