//
//  NetworkError.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation

enum NetworkError: Error {
    case somethingWentWrong
    case errorCode(statusCode: Int)
    case failedToFetchData
}

extension NetworkError {
    var description: String? {
        switch self {
        case .somethingWentWrong:
            return "Something Went Wrong!"
        case .errorCode(let statusCode):
            return "Failed Operation with Status Code: \(statusCode)."
        case .failedToFetchData:
            return "Failed to fetch All Data, Please try again..."
        }
    }
}
