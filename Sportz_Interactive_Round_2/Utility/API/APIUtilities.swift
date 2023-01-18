//
//  APIUtilities.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation

enum NetworkEnvironment {
    case development
    case production
    
    var url: String {
        switch self {
        case .development:
            return ""
        case .production:
            return "https://demo.sportz.io/"
        }
    }
}

enum HTTPMethod {
    case get
    case post
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

class NetworkUtility {
    static let networkEnvironment: NetworkEnvironment = .production
    static let token: String = ""
}
