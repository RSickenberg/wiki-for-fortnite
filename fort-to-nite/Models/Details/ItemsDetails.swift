//
//  ItemsDetails.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 10.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class ItemsDetails: Decodable {

    var itemId: Int
    var isHeal: Bool
    var isExplosive: Bool
    var heal: Int
    var shield: Int
    var delay: Double
    var damages: Int
    var location: [Int]
    var capacity: Int
    var comment: String

    init() {
        itemId = 0
        isHeal = false
        isExplosive = false
        heal = 0
        shield = 0
        delay = 0.0
        damages = 0
        location = [Int]()
        capacity = 0
        comment = ""
    }

    init(itemId: Int, isHeal: Bool, isExplosive: Bool, heal: Int, shield: Int, delay: Double, damages: Int, location: [Int], capacity: Int, comment: String) {
        self.itemId = itemId
        self.isHeal = isHeal
        self.isExplosive = isExplosive
        self.heal = heal
        self.shield = shield
        self.delay = delay
        self.damages = damages
        self.location = location
        self.capacity = capacity
        self.comment = comment
    }
}
