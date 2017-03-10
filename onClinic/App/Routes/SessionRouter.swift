//
//  SessionRoutes.swift
//  onClinic
//
//  Created by MTMAC24 on 3/10/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import Alamofire

enum SessionRouter: URLRequestConvertible {
    
    case login(username: String, password: String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
            case .login:
                return .post
            
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user-login/login"
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Backend.apiURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .login(let username, let password):
            let parameters: Parameters = ["username": username, "password": password]

            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        
    }
}
