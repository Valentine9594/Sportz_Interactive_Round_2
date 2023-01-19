//
//  MatchDetailViewController.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    private var viewModel: MatchDetailViewModelDelegate?

    init(viewModel: MatchDetailViewModelDelegate?) {
        super.init(nibName: "MatchDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



}
