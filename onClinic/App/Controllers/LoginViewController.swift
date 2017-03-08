//
//  LoginController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/8/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import UIKit
import SwiftValidator


class LoginViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    let validator = Validator()
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblErrorUsername: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        
        validator.registerField(tfUsername, errorLabel: lblErrorUsername, rules: [RequiredRule()])
        validator.registerField(tfPassword, errorLabel: lblErrorPassword, rules: [RequiredRule()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        validator.validate(self)
    }
    
    
    @IBAction func btnRegister(_ sender: UIButton) {
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        print("Validation Success")
        hideErrorLabels()
        let alert = UIAlertController(title: "Success", message: "Form Validated!", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        hideErrorLabels()
        for (_, error) in errors {
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
        }
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Validate single field
    // Don't forget to use UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        
        return true
    }
    
    
    // MARK: View helper function
    
    func hideErrorLabels() {
        lblErrorPassword.isHidden = true
        lblErrorUsername.isHidden = true
    }
    
}
