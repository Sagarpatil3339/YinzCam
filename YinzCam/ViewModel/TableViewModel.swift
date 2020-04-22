//
//  TableViewModel.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation
import UIKit

/* Have used Factory Design pattern for managing diferent type of sections based on data */

// Type of sections in tableViews
enum Type {
    case preSeason
    case regularSeason
    case postSeason
}

// In order to enclose each structure in Sections(as BaseClass) and adding important parameters for different sections
protocol Section {
    var type: Type { get }
    var title: String { get }
    var sectionCount: Int { get }
}

class TableViewModel: NSObject {
    // MARK: - Properties
    var items = [Section]()
    
    private var dataService: DataService?
    
    init(dataService: DataService) {
        super.init()
        self.dataService = dataService
    }
    
    // MARK: - Methods
    // Initial network call for fetching json and modeling managing the data of each match in diferent structures and then in sections
    func networkCall(completionHandler: @escaping (_ refresh: Bool) -> ()){
        
        let endPoint : String = Constants.scheduleApi
        
        guard  let endpointUrl = URL(string: endPoint) else {
            return;
        }
        let request = URLRequest(url: endpointUrl);
        
        self.dataService?.httpRequest(request: request) { (received_data, error) in
            if let error = error {
                print(error)
                completionHandler(false)
            }
            guard let successData = received_data, let dataModel = Model(data: successData) else{
                return
            }
            let preSeason = dataModel.preSeason
            if !preSeason.isEmpty {
                let preSeasonItems = PreSeasonSection(preSeason: preSeason)
                self.items.append(preSeasonItems)
            }
            
            let regularSeason = dataModel.regularSeason
            if !regularSeason.isEmpty {
                let regularSeasonItems = RegularSeasonSection(regularSeason: regularSeason)
                self.items.append(regularSeasonItems)
            }
            
            let postSeason = dataModel.postSeason
            if !postSeason.isEmpty {
                let postSeasonItems = PostSeasonSection(postSeason: postSeason)
                self.items.append(postSeasonItems)
            }
            
            completionHandler(true);
        }
    }
}

// MARK: - Table protocal stubs
extension TableViewModel: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].sectionCount
    }
    // Selection of cell types based on "-type" attribute from json in order to populate data of the type: - Final, Scheduled, Bye
    // Dividing data in defferent sections naming - PreSeason, Regular Season, Post Season
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .preSeason:
            if let item = item as? PreSeasonSection, let type = item.preSeasons[indexPath.row].type {
                switch type {
                case "S":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledCell", for: indexPath) as? ScheduledCell{
                        cell.item = item.preSeasons[indexPath.row]
                        return cell
                    }
                case "F":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "FinalCell", for: indexPath) as? FinalCell{
                        cell.item = item.preSeasons[indexPath.row]
                        return cell
                    }
                case "B":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "ByeCell", for: indexPath) as? ByeCell{
                        cell.item = item.preSeasons[indexPath.row]
                        return cell
                    }
                default:
                    let cell = UITableViewCell()
                    return cell
                }
            }
        case .regularSeason:
            if let item = item as? RegularSeasonSection, let type = item.regularSeasons[indexPath.row].type {
                switch type {
                case "S":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledCell", for: indexPath) as? ScheduledCell{
                        cell.item = item.regularSeasons[indexPath.row]
                        return cell
                    }
                case "F":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "FinalCell", for: indexPath) as? FinalCell{
                        cell.item = item.regularSeasons[indexPath.row]
                        return cell
                    }
                case "B":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "ByeCell", for: indexPath) as? ByeCell{
                        cell.item = item.regularSeasons[indexPath.row]
                        return cell
                    }
                default:
                    let cell = UITableViewCell()
                    return cell
                }
            }
        case .postSeason:
            if let item = item as? PostSeasonSection, let type = item.postSeasons[indexPath.row].type {
                switch type {
                case "S":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduledCell", for: indexPath) as? ScheduledCell{
                        cell.item = item.postSeasons[indexPath.row]
                        return cell
                    }
                case "F":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "FinalCell", for: indexPath) as? FinalCell{
                        cell.item = item.postSeasons[indexPath.row]
                        return cell
                    }
                case "B":
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "ByeCell", for: indexPath) as? ByeCell{
                        cell.item = item.postSeasons[indexPath.row]
                        return cell
                    }
                default:
                    let cell = UITableViewCell()
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    // For Customising Section Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let label = UILabel(frame: CGRect(x: 0, y: 14, width: tableView.frame.size.width, height: 32))
        CustomUIElement.forLabel(sender: label, name: Constants.MavenProBoldFont, size: 28, rgbValues: (153.0,153.0,153.0), textAlignment: .center)
        label.text = items[section].title
        if let image = UIImage(named: "list_header.png") {
            view.backgroundColor = UIColor(patternImage: image)
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
}

// MARK: - Section Classes
class PreSeasonSection: Section {
    var type: Type {
        return .preSeason
    }
    
    var title: String {
        return Constants.preSeasonTitle
    }
    
    var sectionCount: Int {
        return preSeasons.count
    }
    
    var preSeasons: [SeasonData]
    
    init(preSeason: [SeasonData]) {
        self.preSeasons = preSeason
    }
}

class RegularSeasonSection: Section {
    var type: Type {
        return .regularSeason
    }
    
    var title: String {
        return Constants.regularSeasonTitle
    }
    
    var sectionCount: Int {
        return regularSeasons.count
    }
    
    var regularSeasons: [SeasonData]
    
    init(regularSeason: [SeasonData]) {
        self.regularSeasons = regularSeason
    }
}

class PostSeasonSection: Section {
    var type: Type {
        return .postSeason
    }
    
    var title: String {
        return Constants.postSeasonTitle
    }
    
    var sectionCount: Int {
        return postSeasons.count
    }
    
    var postSeasons: [SeasonData]
    
    init(postSeason: [SeasonData]) {
        self.postSeasons = postSeason
    }
    
    
}
