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
    
    init() {
        id = 0
        name = ""
        color = 0
        img = ""
    }
    
    init(id: Int, name: String, color: Int, img: String) {
        self.id = id
        self.name = name
        self.color = color
        self.img = img
    }
    
}
