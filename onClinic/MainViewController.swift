//
//  ViewController.swift
//  onClinic
//
//  Created by MTMAC24 on 3/8/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import UIKit
import Foundation


class MainViewController: BaseViewController {

    @IBAction func btnLogout(_ sender: UIButton) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addSlideMenuButton()
        self.title = "onClinic"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

