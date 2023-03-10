//
//  Screen1ViewController.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import UIKit

class ScreenOneViewController: UIViewController {
    
    @IBOutlet weak var fixturesTableview: UITableView!
    
    private var viewModel: ScreenOneViewModelDelegate?
    
    init(viewModel: ScreenOneViewModelDelegate?) {
        super.init(nibName: ViewControllerConstants.screenOneViewController, bundle: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
        fetchAllMatchDetails()
    }
    
    private func setupUI() {
        title = TitleConstants.fixtures
    }
    
    private func fetchAllMatchDetails() {
        viewModel?.fetchMatchData()
    }
    
    private func setupObservers() {
        viewModel?.tableViewShouldReload.bindAndFire(listener: { [unowned self] shouldReload in
            if shouldReload {
                DispatchQueue.main.async {
                    self.fixturesTableview.reloadData()
                }
            }
        })
    }
    
    private func setupTableView() {
        fixturesTableview.delegate = self
        fixturesTableview.dataSource = self
        fixturesTableview.allowsMultipleSelection = false
        fixturesTableview.rowHeight = UITableView.automaticDimension
        
        let fixturesNib = UINib(nibName: TableViewCellConstants.fixturesTableViewCell, bundle: nil)
        fixturesTableview.register(fixturesNib, forCellReuseIdentifier: TableViewCellConstants.fixturesTableViewCell)
    }
}

extension ScreenOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getTotalNumberOfFixtures() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellConstants.fixturesTableViewCell) as? FixturesTableViewCell else { return UITableViewCell() }
        let currentFixture = viewModel?.fetchMatchDetailAt(index: indexPath.row)
        cell.setupFixtureTableViewCell(matchDetailResponse: currentFixture)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFixture = viewModel?.fetchMatchDetailAt(index: indexPath.row)
        let matchDetailViewModel = MatchDetailViewModel(model: currentFixture)
        let matchDetailViewController = MatchDetailViewController(viewModel: matchDetailViewModel)
        navigationController?.pushViewController(matchDetailViewController, animated: true)
    }
}
