//
//  PharmacyCreateViewController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/13/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON
import SwiftValidator


class PharmacyCreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, ValidationDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var tfStockDate: UITextField!
    @IBOutlet weak var tfExpirationDate: UITextField!

    @IBOutlet weak var tfType: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    var units: [Unit] = []
    var unit_id: Int = 0
    let validator = Validator()
    var textFields: [UITextField] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        pickerView.dataSource = self
        pickerView.delegate = self
        
        getUnitData()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(btnSaveAction))
        
        tfName.delegate = self
        tfPrice.delegate = self
        tfQuantity.delegate = self
        tfStockDate.delegate = self
        tfExpirationDate.delegate = self
        tfType.delegate = self
        
        validator.registerField(tfName, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(tfPrice, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(tfQuantity, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(tfStockDate, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(tfExpirationDate, errorLabel: nil, rules: [RequiredRule()])
        validator.registerField(tfType, errorLabel: nil, rules: [RequiredRule()])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Picker view protocol functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row].name!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unit_id = units[row].id!
    }
    
    
    func btnSaveAction() {
        validator.validate(self)
    }

    func savePharmacy() {
        
    }
    
    // MARK: Get unit data
    func getUnitData() {
        Alamofire.request(UnitRouter.index())
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if json["status"] == 200 {
                        let data = json["data"]
                        for (_, unit) in data {
                            self.units.append(Unit(json: unit))
                        }
                        self.pickerView.reloadAllComponents()
                    }
                case .failure(let error):
                    print(error)
                }

        }

    }
    
    // MARK: ValidationDelegate Methods
    
    func validationSuccessful() {
        print("Validation Success")
        savePharmacy()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        tfName.layer.borderColor = UIColor.clear.cgColor
        tfPrice.layer.borderColor = UIColor.clear.cgColor
        tfQuantity.layer.borderColor = UIColor.clear.cgColor
        tfStockDate.layer.borderColor = UIColor.clear.cgColor
        tfExpirationDate.layer.borderColor = UIColor.clear.cgColor
        tfType.layer.borderColor = UIColor.clear.cgColor
        
        for (field, _) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
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
    


}
