//
//  DetailsForObject.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 06.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class DetailsForObjects: NSObject {
    
    private var collection = [Weapons]()
    
    override init() {
        super.init()
    }
    
    func loadDemoData() {
        var weapons = Weapons()
        
        weapons.weaponId = 1
        weapons.weaponName = "Assault Riffle (burst)"
        weapons.weaponColor = "grey"
        weapons.weaponImg = "N/A"
        
        self.addToDB(weapons)
        
        weapons = Weapons()
        
        weapons.weaponId = 2
        weapons.weaponName = "Assault Riffle (burst)"
        weapons.weaponColor = "green"
        weapons.weaponImg = "N/A"
        
        self.addToDB(weapons)
    }
    
    func addToDB(_ weapons: Weapons) {
        collection.append(weapons)
    }
}
