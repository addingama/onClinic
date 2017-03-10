//
//  User.swift
//  onClinic
//
//  Created by MTMAC24 on 3/9/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import UIKit

class User: NSObject {
    
    
    // MARK: Properties
    var name: String
    var id: Int
    var role: String
    var token: String
    
    
    // MARK: Initialization
    override init() {
        self.name = ""
        self.id = 0
        self.role = ""
        self.token = ""
    }
    
    init(id: Int, name: String, role: String, token: String) {
        self.id = id
        self.name = name
        self.role = role
        self.token = token
    }
    
}
