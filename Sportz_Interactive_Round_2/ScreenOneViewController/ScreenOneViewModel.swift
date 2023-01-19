//
//  Screen1ViewModel.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation

protocol ScreenOneViewModelDelegate {
    func fetchMatchData()
}

class ScreenOneViewModel: ScreenOneViewModelDelegate {
    func fetchMatchData() {
        MatchDataService.shared.fetchAllMatchData { matchDetails in
            print(matchDetails)
        }
        
    }
    
    
}
