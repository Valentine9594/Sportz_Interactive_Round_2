//
//  Screen1ViewController.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 18/01/23.
//

import UIKit

class ScreenOneViewController: UIViewController {
    private var viewModel: ScreenOneViewModelDelegate?
    
    init(viewModel: ScreenOneViewModelDelegate?) {
        super.init(nibName: "ScreenOneViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(nibName: "ScreenOneViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllMatchDetails()
    }

    private func fetchAllMatchDetails() {
        viewModel?.fetchMatchData()
    }

}
