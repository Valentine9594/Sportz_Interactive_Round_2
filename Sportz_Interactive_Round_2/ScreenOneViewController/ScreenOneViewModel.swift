//
//  Screen1ViewModel.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import Foundation

protocol ScreenOneViewModelDelegate {
    var tableViewShouldReload: Reactive<Bool> { get }
    
    func fetchMatchData()
    func getTotalNumberOfFixtures() -> Int
    func fetchMatchDetailAt(index: Int) -> MatchDetailResponse?
}

class ScreenOneViewModel: ScreenOneViewModelDelegate {
    private var fixtures: [MatchDetailResponse]?
    var tableViewShouldReload: Reactive<Bool> = Reactive(value: false)
    
    func fetchMatchData() {
        MatchDataService.shared.fetchAllMatchData { matchDetails, error in
            self.fixtures = matchDetails
            print(error?.localizedDescription ?? "No Error")
            self.tableViewShouldReload.accept(true)
        }
        
    }
    
    func getTotalNumberOfFixtures() -> Int {
        return fixtures?.count ?? 0
    }
    
    func fetchMatchDetailAt(index: Int) -> MatchDetailResponse? {
        return fixtures?[index]
    }
    
}
