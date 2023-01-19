//
//  MatchDetailViewModel.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import Foundation

protocol MatchDetailViewModelDelegate {
    var tableViewShouldReload: Reactive<Bool> { get }
    
    func numberOfRowsInSection(for players: DisplayPlayers) -> Int?
    
    func fetchPlayer(indexPath: IndexPath) -> Player?
}

enum DisplayPlayers: CaseIterable {
    case teamHome
    case teamAway
    case allPlayers
    
    var sectionCount: Int {
        switch self {
        case .allPlayers:
            return 2
        case .teamHome, .teamAway:
            return 1
        }
    }
}

class MatchDetailViewModel: MatchDetailViewModelDelegate {
    
    
    private var model: MatchDetailResponse?
    private var teamHomeID: String = ""
    private var teamAwayID: String = ""
    
    private var teamHomePlayers: [Player]? {
        return model?.teams?[self.teamHomeID]?.players?.values.map({ return $0 })
    }
    
    private var teamAwayPlayers: [Player]? {
        return model?.teams?[self.teamAwayID]?.players?.values.map({ return $0 })
    }
    
    var tableViewShouldReload: Reactive<Bool> = Reactive<Bool>(value: false)
    
    init(model: MatchDetailResponse? = nil) {
        self.model = model
        self.teamHomeID = model?.matchdetail?.teamHome ?? ""
        self.teamAwayID = model?.matchdetail?.teamAway ?? ""
    }
    
    func numberOfRowsInSection(for players: DisplayPlayers) -> Int? {
        switch players {
        case .teamHome:
            return teamHomePlayers?.count
        case .teamAway:
            return teamAwayPlayers?.count
        case .allPlayers:
            return nil
        }
    }
    
    func fetchPlayer(indexPath: IndexPath) -> Player? {
        if indexPath.section == 0 {
            return teamHomePlayers?[indexPath.row]
        } else {
            return teamAwayPlayers?[indexPath.row]
        }
    }
    
}
