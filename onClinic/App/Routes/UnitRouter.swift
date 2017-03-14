//
//  UnitRouter.swift
//  onClinic
//
//  Created by MTMAC24 on 3/14/17.
//  Copyright © 2017 MTMAC24. All rights reserved.
//

import Foundation
import Alamofire


enum UnitRouter: URLRequestConvertible {
    
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
            return "/unit"
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Backend.apiURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .index:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        
        return urlRequest
    }
}
