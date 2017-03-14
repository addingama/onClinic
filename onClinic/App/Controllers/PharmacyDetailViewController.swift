//
//  PharmacyDetailViewController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/13/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import UIKit

class PharmacyDetailViewController: UIViewController {
    
    var medicine: Medicine = Medicine()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblExpirationDate: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail"

        // Do any additional setup after loading the view.
        lblName.text = medicine.name!
        lblType.text = medicine.type!
        lblPrice.text = StringFormatter.formatCurrency(value: medicine.price!)
        lblQuantity.text = "\(medicine.quantity!)"
        lblUnit.text = medicine.unitName!
        lblExpirationDate.text = StringFormatter.formatDate(value: medicine.dateExpiration!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
