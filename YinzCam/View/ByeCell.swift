//
//  ByeCell.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

class ByeCell: UITableViewCell {
    // MARK: - UI Elements(Programatically)
    var type : UILabel = {
        let label = UILabel()
        label.text = Constants.byeState
        CustomUIElement.forLabel(sender: label, name: Constants.LeagueGothicRegularFont, size: 100, rgbValues: (153.0,153.0,153.0), textAlignment: .center)
        return label
    }()
    
    var week : UILabel = {
        let label = UILabel()
        CustomUIElement.forLabel(sender: label, name: Constants.MavenProRegularFont, size: 24, rgbValues: (153.0,153.0,153.0), textAlignment: .center)
        return label
    }()
    
    // Setting data from each structure to assign properties to each element of each cell
    var item : SeasonData?  {
        didSet {
            self.week.text = item?.week
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
        addSubview(week)
        addSubview(type)
        setConstraints()
    }
    
    // MARK: - Programatically assigned Constraints
    func setConstraints() {
        week.translatesAutoresizingMaskIntoConstraints = false
        type.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            type.widthAnchor.constraint(equalToConstant: CustomUIElement.windowWidth/3),
            type.centerYAnchor.constraint(equalTo: centerYAnchor),
            type.centerXAnchor.constraint(equalTo: centerXAnchor),
            type.heightAnchor.constraint(equalToConstant: 240/3),
            
            week.widthAnchor.constraint(equalToConstant: 184/640*CustomUIElement.windowWidth),
            week.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.0),
            week.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 15),
            week.heightAnchor.constraint(greaterThanOrEqualToConstant: 39.0),
            week.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
