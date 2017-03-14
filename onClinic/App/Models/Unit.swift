//
//  Unit.swift
//  onClinic
//
//  Created by MTMAC24 on 3/10/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import SwiftyJSON

enum UnitsFields: String {
    case ID = "id"
    case NAME = "name"
}

class Unit {
    var id: Int?
    var name: String?

    init(json: [String: Any]) {
        self.id = json[UnitsFields.ID.rawValue] as? Int
        self.name = (json[UnitsFields.NAME.rawValue] as! NSString) as String
    }
    
    init(json: JSON) {
        self.id = json[UnitsFields.ID.rawValue].int
        self.name = json[UnitsFields.NAME.rawValue].string
    }
}
