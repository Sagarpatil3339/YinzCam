//
//  TableView.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import UIKit

class TableView: UIViewController {
    
    // MARK: - UI Elements(Programatically)
    let table : UITableView = {
        let tableview = UITableView()
        tableview.separatorColor = UIColor.darkGray
        return tableview
    }()
    
    let viewModel = TableViewModel(dataService: DataService())
    
    override func viewDidLoad() {
        title = Constants.scheduleTitle
        super.viewDidLoad()
        viewModel.networkCall() { value in
            if value {
                DispatchQueue.main.async {
                    self.table.reloadData();
                }
            }
        }
        setTable()
        setView()
    }
    
    // MARK: - Methods
    func setTable() {
        table.dataSource = viewModel
        table.delegate = viewModel
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        table.register(ScheduledCell.self, forCellReuseIdentifier: "ScheduledCell")
        table.register(FinalCell.self, forCellReuseIdentifier: "FinalCell")
        table.register(ByeCell.self, forCellReuseIdentifier: "ByeCell")
    }
    
    
    func setView(){
        view.addSubview(table)
        setConstraints()
    }
    
    // For refreshing data with different orientation of the screen
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.table.reloadData()
            } else {
                self.table.reloadData()
            }
        })
    }
    
    // MARK: - Programatically assigned Constraints
    func setConstraints() {
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            table.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            table.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            table.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
