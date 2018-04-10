//
//  ItemsDetails.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 10.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class ItemsDetails: NSObject {
    
    var itemId: Int
    var isHeal: Bool
    var isExplosive: Bool
    var isOneUse: Bool
    var heal: Int
    var delay: Float
    var damages: Int
    var location: String
    
    override init() {
        itemId = 0
        isHeal = false
        isExplosive = false
        isOneUse = false
        heal = 0
        delay = 0.0
        damages = 0
        location = ""
    }
    
    init(itemId: Int, isHeal: Bool, isExplosive: Bool, isOneUse: Bool, heal: Int, delay: Float, damages: Int, location: String) {
        self.itemId = itemId
        self.isHeal = isHeal
        self.isExplosive = isExplosive
        self.isOneUse = isOneUse
        self.heal = heal
        self.delay = delay
        self.damages = damages
        self.location = location
    }
}
