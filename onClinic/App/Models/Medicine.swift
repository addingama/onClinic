//
//  Medicine.swift
//  onClinic
//
//  Created by MTMAC24 on 3/10/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation

enum MedicinesFields: String {
    case ID = "id"
    case NAME = "name"
    case QUANTITY = "quantity"
    case UNIT_ID = "unit_id"
    case PRICE = "price"
    case TYPE = "type"
    case DATE_STOCK = "date_stock"
    case DATE_EXPIRATION = "date_expiration"
    case UNIT_NAME = "unit_name"
}

class Medicine {
    var id: Int?
    var name: String?
    var quantity: Int?
    var unitId: Int?
    var price: Double?
    var type: String?
    var dateStock: String?
    var dateExpiration: String?
    var unitName: String?
    
    init() {
        
    }
    
    required init(json: [String: Any]) {
        
        self.id = json[MedicinesFields.ID.rawValue] as? Int
        self.name = (json[MedicinesFields.NAME.rawValue] as! NSString) as String
        self.quantity = (json[MedicinesFields.QUANTITY.rawValue] as! NSString).integerValue
        self.type = (json[MedicinesFields.TYPE.rawValue] as! NSString) as String
        self.price = (json[MedicinesFields.PRICE.rawValue] as! NSString).doubleValue
        self.unitId = json[MedicinesFields.UNIT_ID.rawValue] as? Int
        self.unitName = (json[MedicinesFields.UNIT_NAME.rawValue] as! NSString) as String
    }
    
}
