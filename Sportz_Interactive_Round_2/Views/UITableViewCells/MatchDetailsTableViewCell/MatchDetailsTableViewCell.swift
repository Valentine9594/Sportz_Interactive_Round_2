//
//  MatchDetailsTableViewCell.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import UIKit

class MatchDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureData(player: Player?) {
        playerNameLabel.text = player?.nameFull ?? ""
        let wicketKeeper = player?.isKeeper
        let captain = player?.isCaptain
    }
}
