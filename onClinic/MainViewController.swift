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
    let session = SessionManager()

    @IBAction func btnLogout(_ sender: UIButton) {
        session.logout()
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

