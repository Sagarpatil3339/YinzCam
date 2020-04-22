//
//  typeCell.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

class FinalCell: UITableViewCell {
    // MARK: - UI Elements(Programatically)
    var teamName : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.LeagueGothicRegularFont, size: 40.0)
        return label
    }()
    
    var opponentTeam : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.LeagueGothicRegularFont, size: 40.0, textAlignment: .right)
        return label
    }()
    
    var date : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.MavenProRegularFont, size: 24)
        return label
    }()
    
    var week : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.MavenProRegularFont, size: 24, rgbValues: (153.0,153.0,153.0), textAlignment: .center)
        return label
    }()
    
    var homeScore : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.LeagueGothicRegularFont, size: 60.0)
        return label
    }()
    
    var awayScore : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.LeagueGothicRegularFont, size: 60.0, textAlignment: .right)
        return label
    }()
    
    var vs : UILabel = {
        let label = UILabel()
        label.text = Constants.vs
        CustomUIElement.forLabel(sender: label, name: Constants.LeagueGothicRegularFont, size: 28.0, textAlignment: .center)
        return label
    }()
    
    var type : UILabel = {
        let label = UILabel()
        label.text = Constants.finalState
        CustomUIElement.forLabel(sender: label, name: Constants.MavenProRegularFont, size: 24, textAlignment: .right)
        return label
    }()
    
    var homeIcon : UIImageView = UIImageView()
    var awayIcon : UIImageView = UIImageView()
    
    // Setting data from each structure to assign properties to each element of each cell
    var item : SeasonData?  {
        didSet {
            self.teamName.text = item?.teamName
            self.opponentTeam.text = item?.opponentTeam
            self.date.text = item?.date
            self.week.text = item?.week
            self.homeScore.text = item?.homeScore
            self.awayScore.text = item?.awayScore
            
            if let homeIconURL = item?.teamTriColor {
                DataService().downloadImage(url: homeIconURL, completion: { (image, error) in
                    if let error = error {
                        print("loading image error: \(error)")
                    } else {
                        self.homeIcon.image = image
                    }
                })
            }
            if let awayIconURL = item?.opponentTriColor {
                DataService().downloadImage(url: awayIconURL, completion: { (image, error) in
                    if let error = error {
                        print("loading image error: \(error)")
                    } else {
                        self.awayIcon.image = image
                    }
                })
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupView() {
        backgroundColor = .white
        addSubview(homeIcon)
        addSubview(awayIcon)
        addSubview(teamName)
        addSubview(opponentTeam)
        addSubview(homeScore)
        addSubview(awayScore)
        addSubview(date)
        addSubview(week)
        addSubview(type)
        addSubview(vs)
        setConstraints()
    }
    
    // MARK: - Programatically assigned Constraints
    func setConstraints() {
        homeIcon.translatesAutoresizingMaskIntoConstraints = false
        awayIcon.translatesAutoresizingMaskIntoConstraints = false
        teamName.translatesAutoresizingMaskIntoConstraints = false
        opponentTeam.translatesAutoresizingMaskIntoConstraints = false
        homeScore.translatesAutoresizingMaskIntoConstraints = false
        awayScore.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        week.translatesAutoresizingMaskIntoConstraints = false
        type.translatesAutoresizingMaskIntoConstraints = false
        vs.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeIcon.widthAnchor.constraint(equalToConstant: 80.0/640*CustomUIElement.windowWidth),
            homeIcon.heightAnchor.constraint(equalToConstant: 80.0/640*CustomUIElement.windowWidth),
            homeIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeIcon.trailingAnchor.constraint(equalTo: vs.leadingAnchor, constant: 0),
            
            vs.widthAnchor.constraint(equalToConstant: 80.0/640*CustomUIElement.windowWidth),
            vs.heightAnchor.constraint(equalToConstant: 80.0/640*CustomUIElement.windowWidth),
            vs.centerYAnchor.constraint(equalTo: centerYAnchor),
            vs.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            awayIcon.widthAnchor.constraint(equalToConstant: 80.0/640*CustomUIElement.windowWidth),
            awayIcon.heightAnchor.constraint(equalToConstant: 80.0/640*CustomUIElement.windowWidth),
            awayIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            awayIcon.leadingAnchor.constraint(equalTo: vs.trailingAnchor, constant: 0),
            
            teamName.widthAnchor.constraint(equalToConstant: 300.0/640*CustomUIElement.windowWidth),
            teamName.heightAnchor.constraint(equalToConstant: 44.0),
            teamName.topAnchor.constraint(equalTo: topAnchor, constant: 28.0),
            teamName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0/640*CustomUIElement.windowWidth),
            
            opponentTeam.widthAnchor.constraint(equalToConstant: 300.0/640*CustomUIElement.windowWidth),
            opponentTeam.heightAnchor.constraint(equalToConstant: 44.0),
            opponentTeam.topAnchor.constraint(equalTo: topAnchor, constant: 28.0),
            opponentTeam.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0/640*CustomUIElement.windowWidth),
            
            homeScore.widthAnchor.constraint(equalToConstant: 184.0/640*CustomUIElement.windowWidth),
            homeScore.heightAnchor.constraint(equalToConstant: 72.0),
            homeScore.topAnchor.constraint(equalTo: teamName.bottomAnchor, constant: 12.0),
            homeScore.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0/640*CustomUIElement.windowWidth),
            
            awayScore.widthAnchor.constraint(equalToConstant: 184.0/640*CustomUIElement.windowWidth),
            awayScore.heightAnchor.constraint(equalToConstant: 72.0),
            awayScore.topAnchor.constraint(equalTo: opponentTeam.bottomAnchor, constant: 12.0),
            awayScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0/640*CustomUIElement.windowWidth),
            
            type.widthAnchor.constraint(equalToConstant: 184.0/640*CustomUIElement.windowWidth),
            type.topAnchor.constraint(equalTo: awayScore.bottomAnchor, constant: 15.0),
            type.heightAnchor.constraint(equalToConstant: 39.0),
            type.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0/640*CustomUIElement.windowWidth),
            
            date.widthAnchor.constraint(equalToConstant: 184.0/640*CustomUIElement.windowWidth),
            date.heightAnchor.constraint(equalToConstant: 39.0),
            date.topAnchor.constraint(equalTo: type.topAnchor),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0/640*CustomUIElement.windowWidth),
            
            week.widthAnchor.constraint(equalToConstant: 184/640*CustomUIElement.windowWidth),
            week.centerXAnchor.constraint(equalTo: centerXAnchor),
            week.heightAnchor.constraint(greaterThanOrEqualToConstant: 39.0),
            week.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.0),
            week.topAnchor.constraint(equalTo: type.topAnchor),
        ])
    }
}
