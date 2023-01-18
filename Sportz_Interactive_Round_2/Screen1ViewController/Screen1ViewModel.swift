//
//  Screen1ViewModel.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation

protocol Screen1ViewModelDelegate {
    func fetchData()
}

class Screen1ViewModel: Screen1ViewModelDelegate {
    func fetchData() {
        APIManager.shared.performRequest(apiService: .matchDataOne(params: nil)) { result in
            switch result {
            case .success(let value):
                guard let value = value else { return }
                print(String(data: value, encoding: .utf8))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
