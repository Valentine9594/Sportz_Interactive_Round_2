//
//  APIServices.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation


//https://demo.sportz.io/nzin01312019187360.json
//https://demo.sportz.io/sapk01222019186652.json

typealias NetworkParameters = [String: Any]
typealias NetworkHeaders = [String: String]

enum APIService {
    case matchDataOne(params: NetworkParameters?)
    case matchDataTwo(params: NetworkParameters?)
}

extension APIService {
    
    var path: String {
        var remainingPath = ""
        switch self {
        case .matchDataOne:
            remainingPath = "nzin01312019187360.json"
        case .matchDataTwo:
            remainingPath = "nzin01312019187360.json"
        }
        return NetworkUtility.networkEnvironment.url + remainingPath
    }
    
    var method: HTTPMethod {
        switch self {
            case .matchDataOne, .matchDataTwo:
                return .get
        }
    }
    
    var headers: NetworkHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: NetworkParameters? {
        switch self {
        case .matchDataOne(let params), .matchDataTwo(let params):
            return params
        }
    }
}
