//
//  PreSeason.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
import UIKit

/* Structuring data for each instace of JSON Array*/

struct SeasonData {
    var teamName: String?
    var teamTriColor: String?
    var opponentTeam: String?
    var opponentTriColor: String?
    var week: String?
    var type: String?
    var awayScore: String?
    var homeScore: String?
    var time: String?
    var date: String?
    var homeRecord: String?
    var awayRecord: String?    
    
    init(json: [String: Any], teamName: String, teamTriColor: String, record: String) {
        self.teamName = teamName
        self.teamTriColor = "\(Constants.imageURLStart)\(teamTriColor.lowercased())\(Constants.imageURLEnd)"
        self.homeRecord = record
        self.week = json["-Week"] as? String
        self.type = json["-Type"] as? String
        self.awayScore = json["-AwayScore"] as? String
        self.homeScore = json["-HomeScore"] as? String
        
        if let opponent = json["Opponent"] as? [String : Any] {
            self.opponentTeam = opponent["-Name"] as? String
            if let triCode = opponent["-TriCode"] as? String {
                self.opponentTriColor = "\(Constants.imageURLStart)\(triCode.lowercased())\(Constants.imageURLEnd)"
            }
            self.awayRecord = opponent["-Record"] as? String
        }
        if let dateData = json["Date"] as? [String : Any], let timestamp = dateData["-Timestamp"] as? String {
            let dateTimeObject = DateTimeExtractor(Timestamp: timestamp)
            self.date = dateTimeObject.date
            self.time = dateTimeObject.time
        }
    }
}
