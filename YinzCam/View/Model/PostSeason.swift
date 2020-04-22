//
//  PostSeason.swift
//  YinzCam
//
//  Created by Prasad Patil on 4/19/20.
//  Copyright © 2020 Prasad Patil. All rights reserved.
//

import Foundation

struct PostSeason {
    var name: String?
    var description: String?
    var author: String?
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.description = json["description"] as? String
        self.author = json["author"] as? String
    }
    
}
