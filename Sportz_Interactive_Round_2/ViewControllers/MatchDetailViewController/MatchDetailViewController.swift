//
//  MatchDetailViewController.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var teamsTableView: UITableView!
    
    private var viewModel: MatchDetailViewModelDelegate?

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
        filterButton.layer.cornerRadius = filterButton.frame.size.width / 2
        filterButton.layer.borderColor = UIColor.black.cgColor
        filterButton.layer.borderWidth = 1
    }
    
    private func setupTableView() {
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        
        teamsTableView.rowHeight = UITableView.automaticDimension
        teamsTableView.allowsMultipleSelection = false
        
        let matchDetailsTableviewCellNib = UINib(nibName: "MatchDetailsTableViewCell", bundle: nil)
        teamsTableView.register(matchDetailsTableviewCellNib, forCellReuseIdentifier: "MatchDetailsTableViewCell")
    }
    
    @IBAction func clickedFilterButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Select Sorting Factor", message: nil, preferredStyle: .actionSheet)
        let allPlayersAction = UIAlertAction(title: "All Players", style: .default) { action in
            self.viewModel?.displayPlayers = .allPlayers
            self.teamsTableView.reloadData()
        }
        let teamHomeAction = UIAlertAction(title: viewModel?.getTeamHomeName, style: .default) { action in
            self.viewModel?.displayPlayers = .teamHome
            self.teamsTableView.reloadData()
        }
        let teamAwayAction = UIAlertAction(title: viewModel?.getTeamAwayName, style: .default) { action in
            self.viewModel?.displayPlayers = .teamAway
            self.teamsTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(allPlayersAction)
        alertController.addAction(teamHomeAction)
        alertController.addAction(teamAwayAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

}

extension MatchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.displayPlayers.sectionCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailsTableViewCell", for: indexPath) as? MatchDetailsTableViewCell else { return UITableViewCell() }
        let player = viewModel?.fetchPlayer(indexPath: indexPath)
        cell.configureData(player: player)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.getHeaderTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = viewModel?.fetchPlayer(indexPath: indexPath)
        getPlayerMatchStylesAlert(player: player)
    }
    
    private func getPlayerMatchStylesAlert(player: Player?) {
        var message = "Battle Style: \(player?.batting?.style?.rawValue ?? "N/A")\n"
        message += "Bowling Style: \(player?.bowling?.style ?? "N/A")"
        let alertController = UIAlertController(title: "\(player?.nameFull ?? "")", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true)
    }
}
