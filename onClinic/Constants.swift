//
//  Constants.swift
//  onClinic
//
//  Created by MTMAC24 on 3/8/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation

struct Backend {
    static let baseURL = "http://172.19.11.20:8080/clinic/web"
    static let apiURL = "\(Backend.baseURL)/v1"
}

struct SessionKey {
    static let isLoggedIn = "userLoggedIn"
    static let token = "authToken"
    static let user = "user"
}
