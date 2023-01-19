//
//  MatchDetailViewController.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var teamsTableView: UITableView!
    private var viewModel: MatchDetailViewModelDelegate?
    private var displayPlayers: DisplayPlayers = .allPlayers

    init(viewModel: MatchDetailViewModelDelegate?) {
        super.init(nibName: "MatchDetailViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    private func setupUI() {
        
    }
    
    private func setupTableView() {
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        
        teamsTableView.rowHeight = UITableView.automaticDimension
        teamsTableView.allowsMultipleSelection = false
        
        let matchDetailsTableviewCellNib = UINib(nibName: "MatchDetailsTableViewCell", bundle: nil)
        teamsTableView.register(matchDetailsTableviewCellNib, forCellReuseIdentifier: "MatchDetailsTableViewCell")
    }

}

extension MatchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayPlayers.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let team: DisplayPlayers = section == 0 ? .teamHome : .teamAway
        return viewModel?.numberOfRowsInSection(for: team) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailsTableViewCell", for: indexPath) as? MatchDetailsTableViewCell else { return UITableViewCell() }
        let player = viewModel?.fetchPlayer(indexPath: indexPath)
        cell.configureData(player: player)
        return cell
    }
    
    
}
