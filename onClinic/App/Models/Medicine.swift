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
    case UNIT = "unit"
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
    var unit: Unit?
    
    required init(json: [String: Any]) {
        self.id = json[MedicinesFields.ID.rawValue] as? Int
        self.name = json[MedicinesFields.NAME.rawValue] as? String
    }
    
}
