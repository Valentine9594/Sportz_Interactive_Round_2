//
//  APIManager.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation

final class APIManager {
    
    private init() {}
    static let shared = APIManager()
    
    func performRequest(apiService: APIService, completion: @escaping((Result<Data?, Error>)->())) {
        
        guard let url = URL(string: apiService.path) else { return }
        var urlRequest = URLRequest(url: url, timeoutInterval: .infinity)
        
        urlRequest.allHTTPHeaderFields = apiService.headers
        urlRequest.httpMethod = apiService.method.description
        
        if let params = apiService.parameters {
            switch apiService.method {
                case .get:
                    var urlComponents = URLComponents(string: apiService.path)
                    urlComponents?.queryItems = params.map({ (key, value) in
                        URLQueryItem(name: key, value: String(describing: value))
                    })
                    urlRequest.url = urlComponents?.url
                case .post:
                    var urlComponents = URLComponents()
                    urlComponents.queryItems = params.map({ (key, value) in
                        URLQueryItem(name: key, value: String(describing: value))
                    })
                urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                completion(.success(data))
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                completion(.failure(NetworkError.somethingWentWrong))
            }
            
        }.resume()
        
    }
    
    
}
