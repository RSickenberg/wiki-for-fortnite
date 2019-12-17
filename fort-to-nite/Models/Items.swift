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
    var variants: Int
    var image: String
    var group: Int
    var isRemoved: Bool
    var isIncomplete: Bool?
    
    init() {
        id = 0
        name = ""
        variants = 0
        image = ""
        group = 0
        isRemoved = false
        isIncomplete = false
    }
    
    init(id: Int, name: String, variants: Int, image: String, group: Int, isRemoved: Bool, isIncomplete: Bool?) {
        self.id = id
        self.name = name
        self.variants = variants
        self.image = image
        self.group = group
        self.isRemoved = isRemoved
        self.isIncomplete = isIncomplete
    }
}
