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
import Alamofire


class LoginViewController: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    let validator = Validator()
    let session = SessionManager()
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblErrorUsername: UILabel!
    @IBOutlet weak var lblErrorPassword: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingBackdrop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        
        validator.registerField(tfUsername, errorLabel: lblErrorUsername, rules: [RequiredRule()])
        validator.registerField(tfPassword, errorLabel: lblErrorPassword, rules: [RequiredRule()])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !session.isLoggedIn() {
            print("user not logged in")
        } else {
            print("userLoggedIn")
            self.showMainScene()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

    }

    
    @IBAction func btnSignIn(_ sender: UIButton) {
        validator.validate(self)
    }
    
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let url = URL(string: "\(Backend.baseURL)/register")!
        UIApplication.shared.open(url, options: [:])
    }
    
    func doLogin() {
        showLoading()
        let username = tfUsername.text!
        let password = tfPassword.text!
        Alamofire.request(SessionRouter.login(username: username, password: password))
            .responseJSON { (response) in
                self.hideLoading()
                // debugPrint(response)
                
                if response.result.value == nil {
                    self.showAlert(title: "Error", message: "Something error with the server. Sorry for the inconvenience")
                } else {
                    if let responseJson = response.result.value as? [String: Any] {
                        print("JSON: \(responseJson)")
                        
                        if responseJson["status"] != nil {
                            let status = responseJson["status"] as! Bool
                            let message = responseJson["message"] as! String
                            
                            if status {
                                let user = responseJson["data"] as! [String: Any]
                                self.storeSession(user: user)
                                
                                
                                
                                self.clearInputs()
                                self.showMainScene()
                                
                            } else {
                                self.showAlert(title: "Error", message: message)
                            }
                        } else {
                            self.showAlert(title: "Error", message: "Response data is not valid")
                        }
                    }
                }
                
                
        }
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        print("Validation Success")
        hideErrorLabels()
        doLogin()
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
    
    // MARK: Helper functions
    
    func storeSession(user: [String: Any]) {
        let id = user["id"] as! Int
        let name = user["name"] as! String
        let role = user["role"] as! String
        let token = user["token"] as! String
        session.setUserId(id: id)
        session.setUserName(name: name)
        session.setUserRole(role: role)
        session.setAuthToken(token: token)
        session.setLoginStatus(status: true)
        session.setUser(user: user)
    }
    
    
    // MARK: View helper function
    func clearInputs() {
        tfUsername.text = ""
        tfPassword.text = ""
    }
    
    func hideErrorLabels() {
        lblErrorPassword.isHidden = true
        lblErrorUsername.isHidden = true
    }
    
    func showLoading() {
        loadingIndicator.startAnimating()
        loadingBackdrop.isHidden = false
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
        loadingBackdrop.isHidden = true
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMainScene() {
        print("show main scene")
        self.performSegue(withIdentifier: "MainVCSegue", sender: nil)

    }
}
