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
    @IBOutlet weak var matchResultLabel: UILabel!
    @IBOutlet weak var versusLabel: UILabel!
    
    @IBOutlet weak var seriesDetailLbbel: UILabel!
    
    @IBOutlet weak var seriesNameLabel: UILabel!
    
    @IBOutlet weak var matchNumberLabel: UILabel!
    
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var homeTeamOvers: UILabel!
    
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var awayTeamOvers: UILabel!
    
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        matchTeamAwayLabel.numberOfLines = 0
        matchTeamAwayLabel.lineBreakMode = .byWordWrapping

        matchTeamHomeLabel.numberOfLines = 0
        matchTeamHomeLabel.lineBreakMode = .byWordWrapping
        
        bottomStackView.layer.cornerRadius = 10
        baseView.layer.cornerRadius = 10
        bottomStackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
    }
    
    func setupFixtureTableViewCell(matchDetailResponse: MatchDetailResponse?) {
        matchDateLabel.text = matchDetailResponse?.matchdetail?.match?.date ?? "T.B.D"
        setMatchTeams(matchDetail: matchDetailResponse)
        matchResultLabel.text = matchDetailResponse?.matchdetail?.result ?? "N.A"
        seriesDetailLbbel.text = "(\( matchDetailResponse?.matchdetail?.series?.status ?? "N.A" ))"
        seriesNameLabel.text = matchDetailResponse?.matchdetail?.series?.tourName ?? "N.A"
        matchNumberLabel.text = matchDetailResponse?.matchdetail?.match?.number
    }
    
    private func setMatchTeams(matchDetail: MatchDetailResponse?) {
        let teamHome = matchDetail?.matchdetail?.teamHome ?? "0"
        let teamAway = matchDetail?.matchdetail?.teamAway ?? "0"
        var homeInning: Inning?
        var awayInning: Inning?
        
        matchTeamAwayLabel.text = matchDetail?.teams?[teamAway]?.nameShort ?? "Team One"
        matchTeamHomeLabel.text = matchDetail?.teams?[teamHome]?.nameShort ?? "Team Two"
        
        matchDetail?.innings?.forEach({ inning in
            if inning.battingteam == teamHome {
                homeInning = inning
            } else if inning.battingteam == teamAway {
                awayInning = inning
            }
        })
        
        homeTeamOvers.text = "(\(homeInning?.overs ?? "N.A"))"
        awayTeamOvers.text = "(\(awayInning?.overs ?? "N.A"))"
        
        homeTeamScore.text = "\(homeInning?.total ?? "N.A")/\(homeInning?.wickets ?? "N.A")"
        
        awayTeamScore.text = "\(awayInning?.total ?? "N.A")/\(awayInning?.wickets ?? "N.A")"
    }
    
}
