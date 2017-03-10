//
//  MedicineRouter.swift
//  onClinic
//
//  Created by MTMAC24 on 3/10/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import Alamofire

enum MedicineRouter: URLRequestConvertible {
    
    case index()
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .index:
            return .get
            
        }
    }
    
    var path: String {
        switch self {
        case .index:
            return "/medicine"
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Backend.apiURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .index():
            return try Alamofire.JSONEncoding.default.encode(urlRequest)
        }
        
    }
}
