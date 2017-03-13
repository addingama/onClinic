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
    case update(Int, Medicine)
    case delete(Int)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .index:
            return .get
        case .update:
            return .put
        case .delete:
            return .delete
            
        }
    }
    
    var path: String {
        switch self {
        case .index:
            return "/medicine"
        case .update(let id, let _):
            return "/medicine/update?id=\(id)"
        case .delete(let id):
            return "/medicine/delete?id=\(id)"
        default:
            return ""
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Backend.apiURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .index():
            return try Alamofire.JSONEncoding.default.encode(urlRequest)
        default:
            return try Alamofire.JSONEncoding.default.encode(urlRequest)
                }
        
    }
}
