//
//  MatchDataService.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import Foundation

class MatchDataService {
    
    private init() {}
    static let shared = MatchDataService()
    typealias MatchDetailsReceive = (Result<MatchDetailResponse, Error>)->()
    typealias AllMatchDetailsReceived = ([MatchDetailResponse])->()
    
    func fetchMatchDataOneAPI(completion: @escaping(MatchDetailsReceive)) {
        APIManager.shared.performRequest(apiService: .matchDataOne(params: nil)) { result in
            switch result {
            case .success(let value):
                guard let value = value else { return }
                let jsonDecoder = JSONDecoder()
                if let model = try? jsonDecoder.decode(MatchDetailResponse.self, from: value) {
                    completion(.success(model))
                } else {
                    completion(.failure(NetworkError.somethingWentWrong))
                }
            case .failure(let error):
                completion(.failure(NetworkError.somethingWentWrong))
            }
        }
    }
    
    func fetchMatchDataTwoAPI(completion: @escaping(MatchDetailsReceive)) {
        APIManager.shared.performRequest(apiService: .matchDataTwo(params: nil)) { result in
            switch result {
            case .success(let value):
                guard let value = value else { return }
                let jsonDecoder = JSONDecoder()
                if let model = try? jsonDecoder.decode(MatchDetailResponse.self, from: value) {
                    completion(.success(model))
                } else {
                    completion(.failure(NetworkError.somethingWentWrong))
                }
            case .failure(let error):
                completion(.failure(NetworkError.somethingWentWrong))
            }
        }
    }
    
    func fetchAllMatchData(completion: @escaping(AllMatchDetailsReceived)) {
        var matchDetails = [MatchDetailResponse]()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchMatchDataOneAPI { result in
            switch result {
            case .success(let value):
                matchDetails.append(value)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.enter()
        fetchMatchDataTwoAPI { result in
            switch result {
            case .success(let value):
                matchDetails.append(value)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(matchDetails)
        }
        
        
    }
    
}
