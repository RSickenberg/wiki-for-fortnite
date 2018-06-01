//
//  Weapons.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//  Todo: Make model for details only
//  Todo: var detailId: Int
//

import Foundation

class Weapons: Decodable {
    
    var id: Int
    var detailId: Int
    var name: String
    var color: Int
    var img: String
    
    init() {
        id = 0
        detailId = 0
        name = ""
        color = 0
        img = ""
    }
    
    init(id: Int, detailId: Int, name: String, color: Int, img: String) {
        
        self.id = id
        self.detailId = detailId
        self.name = name
        self.color = color
        self.img = img
    }
    
}
