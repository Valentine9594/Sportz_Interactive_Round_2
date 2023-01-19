//
//  FixturesTableViewCell.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import UIKit

class FixturesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var matchDateLabel: UILabel!
    @IBOutlet weak var matchTeamAwayLabel: UILabel!
    @IBOutlet weak var matchTeamHomeLabel: UILabel!
    @IBOutlet weak var matchVenueLabel: UILabel!
    @IBOutlet weak var versusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupFixtureTableViewCell(matchDetailResponse: MatchDetailResponse?) {
        matchDateLabel.text = matchDetailResponse?.matchdetail?.match?.date ?? "T.B.D"
        setMatchTeams(matchDetail: matchDetailResponse)
        matchVenueLabel.text = matchDetailResponse?.matchdetail?.venue?.name ?? "T.B.A"
    }
    
    private func setMatchTeams(matchDetail: MatchDetailResponse?) {
        let teamHome = matchDetail?.matchdetail?.teamHome ?? "0"
        let teamAway = matchDetail?.matchdetail?.teamAway ?? "0"
        
        matchTeamAwayLabel.text = matchDetail?.teams?[teamAway]?.nameFull ?? "Team One"
        matchTeamHomeLabel.text = matchDetail?.teams?[teamHome]?.nameFull ?? "Team Two"
    }
    
}
