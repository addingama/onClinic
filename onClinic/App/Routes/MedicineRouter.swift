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
        case .update(_, _):
            return "/medicine/update"
        case .delete( _):
            return "/medicine/delete"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Backend.apiURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        switch self {
        case .index():
            urlRequest = try Alamofire.JSONEncoding.default.encode(urlRequest)
        case .update(let id, let medicine):
            let parameters: Parameters = ["id": id, "name": medicine.name!, "quantity": medicine.quantity!, "price": medicine.price!, "type": medicine.type!, "date_stock": medicine.dateStock!, "date_expiration": medicine.dateExpiration!, "unit_id": medicine.unitId!]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)

        case .delete(let id):
            let parameters: Parameters = ["id": id]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }

        return urlRequest
        
    }
}
