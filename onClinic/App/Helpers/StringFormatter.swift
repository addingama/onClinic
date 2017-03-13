//
//  StringFormatter.swift
//  onClinic
//
//  Created by MTMAC24 on 3/13/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation

class StringFormatter {
    
    static func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "id")
        let result = formatter.string(from: value as NSNumber)
        return "Rp. \(result!),-"
    }
}
