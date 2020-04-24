//
//  Model.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation

/* Modelling JSON data into structures and setting them for different Sections*/

class Model {
    var preSeason = [SeasonData]()
    var regularSeason = [SeasonData]()
    var postSeason = [SeasonData]()
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let gameList = json["GameList"] as? [String: Any], let team = gameList["Team"] as? [String: Any], let teamName = team["-Name"] as? String, let record = team["-Record"] as? String, let teamTriColor = team["-TriCode"] as? String ,let gameSection = gameList["GameSection"] as? [[String: Any]] {
                for each in gameSection {
                    if let heading = each["-Heading"] as? String, heading == "PRESEASON"  {
                        if let game = each["Game"] as? [[String: Any]] {
                            self.preSeason = game.map { SeasonData(json: $0, teamName: teamName, teamTriColor: teamTriColor, record: record) }
                        } else if let game = each["Game"] as? [String: Any] {
                            self.preSeason = [SeasonData(json: game, teamName: teamName, teamTriColor: teamTriColor, record: record)]
                        }
                    }
                    if let heading = each["-Heading"] as? String, heading == "REGULAR SEASON" {
                        if let game = each["Game"] as? [[String: Any]] {
                            self.regularSeason = game.map { SeasonData(json: $0, teamName: teamName, teamTriColor: teamTriColor, record: record) }
                        } else if let game = each["Game"] as? [String: Any] {
                            self.regularSeason = [SeasonData(json: game, teamName: teamName, teamTriColor: teamTriColor, record: record)]
                        }
                    }
                    if let heading = each["-Heading"] as? String, heading == "POSTSEASON" {
                        if let game = each["Game"] as? [[String: Any]] {
                            self.postSeason = game.map { SeasonData(json: $0, teamName: teamName, teamTriColor: teamTriColor, record: record) }
                        } else if let game = each["Game"] as? [String: Any] {
                            self.postSeason = [SeasonData(json: game, teamName: teamName, teamTriColor: teamTriColor, record: record)]
                        }
                    }
                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}
