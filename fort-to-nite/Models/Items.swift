//
//  Items.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class Items: Decodable {
    
    var id: Int
    var name: String
    var color: Int
    var img: String
    var group: Int
    
    init() {
        id = 0
        name = ""
        color = 0
        img = ""
        group = 0
    }
    
    init(id: Int, name: String, color: Int, img: String, group: Int) {
        self.id = id
        self.name = name
        self.color = color
        self.img = img
        self.group = group
    }
    
}
