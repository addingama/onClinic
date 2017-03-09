//
//  ApiManager.swift
//  onClinic
//
//  Created by MTMAC24 on 3/9/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let login = generateUrl(path: "/user-login/login")
    
    
    static func generateUrl(path: String) -> String {
        return "\(Backend.apiURL)\(path)"
    }
    
}
