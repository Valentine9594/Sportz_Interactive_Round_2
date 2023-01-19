//
//  MatchDetailViewModel.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import Foundation

protocol MatchDetailViewModelDelegate {
    var tableViewShouldReload: Reactive<Bool> { get }
    
}

class MatchDetailViewModel: MatchDetailViewModelDelegate {
    private var model: MatchDetailResponse?
    var tableViewShouldReload: Reactive<Bool> = Reactive<Bool>(value: false)
    
    init(model: MatchDetailResponse? = nil) {
        self.model = model
    }
    
    
}
