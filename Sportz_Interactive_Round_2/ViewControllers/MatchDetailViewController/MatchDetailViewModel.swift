//
//  MatchDetailViewModel.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import Foundation

protocol MatchDetailViewModelDelegate {
    var tableShouldReload: Reactive<Bool> { get }
    var displayPlayers: DisplayPlayers { get set }
    
    func numberOfRowsInSection(section: Int) -> Int?
    
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
    var displayPlayers: DisplayPlayers = .allPlayers
    
    private var teamHomePlayers: [Player]? {
        return model?.teams?[self.teamHomeID]?.players?.values.map({ return $0 })
    }
    
    private var teamAwayPlayers: [Player]? {
        return model?.teams?[self.teamAwayID]?.players?.values.map({ return $0 })
    }
    
    var tableShouldReload: Reactive<Bool> = Reactive<Bool>(value: false)
    
    init(model: MatchDetailResponse? = nil) {
        self.model = model
        self.teamHomeID = model?.matchdetail?.teamHome ?? ""
        self.teamAwayID = model?.matchdetail?.teamAway ?? ""
    }
    
    func numberOfRowsInSection(section: Int) -> Int? {
        switch displayPlayers {
        case .teamHome:
            return teamHomePlayers?.count
        case .teamAway:
            return teamAwayPlayers?.count
        case .allPlayers:
            if section == 0 {
                return teamHomePlayers?.count ?? 0
            } else {
                return teamAwayPlayers?.count ?? 0
            }
        }
    }
    
    func fetchPlayer(indexPath: IndexPath) -> Player? {
        switch displayPlayers {
        case .teamHome:
            return teamHomePlayers?[indexPath.row]
        case .teamAway:
            return teamAwayPlayers?[indexPath.row]
        case .allPlayers:
            if indexPath.section == 0 {
                return teamHomePlayers?[indexPath.row]
            } else {
                return teamAwayPlayers?[indexPath.row]
            }
        }
    }
    
}
