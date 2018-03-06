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
        
        self.loadDemoData()
    }
    
    func loadDemoData() {
        var weapons = Weapons()
        
        weapons.weaponId = 0
        weapons.weaponName = "Assault Riffle (burst)"
        weapons.weaponColor = "grey"
        weapons.weaponImg =  "ar_burst"
        
        weapons.damage = 27
        weapons.criticalHitChance = 0
        weapons.criticalHitDmg = 0
        weapons.fireRate = 1.75
        weapons.magazineSize = 30
        weapons.range = 1
        weapons.durability = 100
        weapons.reloadTime = 2.9
        weapons.ammoCost = 1
        weapons.impact = 40
        
        weapons.spreadBase = 0.175
        weapons.spreadSprint =  1.5
        weapons.spreadJump = 1.25
        weapons.spreadDownsights = 0.65
        weapons.spreadStanding = 0.55
        weapons.spreadCrouching = 0.75
        
        weapons.firingRateNormal = 1.75
        weapons.firingRateBurst = 12
        
        weapons.environementDamage = 30
        weapons.impactDamage = 40
        
        weapons.recoilHorizontal = 0.25
        weapons.recoilVertical = 1.925
        weapons.recoilMaxAngle = 25
        weapons.recoilMinAngle = -25
        weapons.recoilDownsights = 0.5
        
        self.addToDB(weapons)
        
        weapons = Weapons()
        
        weapons.weaponId = 1
        weapons.weaponName = "Assault Riffle (burst)"
        weapons.weaponColor = "green"
        weapons.weaponImg = "ar_burst"
        
        weapons.damage = 29
        weapons.criticalHitChance = 0
        weapons.criticalHitDmg = 0
        weapons.fireRate = 1.75
        weapons.magazineSize = 30
        weapons.range = 1
        weapons.durability = 100
        weapons.reloadTime = 2.7
        weapons.ammoCost = 1
        weapons.impact = 42
        
        weapons.spreadBase = 0.175
        weapons.spreadSprint =  1.5
        weapons.spreadJump = 1.25
        weapons.spreadDownsights = 0.65
        weapons.spreadStanding = 0.55
        weapons.spreadCrouching = 0.75
        
        weapons.firingRateNormal = 1.75
        weapons.firingRateBurst = 12
        
        weapons.environementDamage = 30
        weapons.impactDamage = 42
        
        weapons.recoilHorizontal = 0.25
        weapons.recoilVertical = 1.8375
        weapons.recoilMaxAngle = 25
        weapons.recoilMinAngle = -25
        weapons.recoilDownsights = 0.5
        
        self.addToDB(weapons)
    }
    
    func addToDB(_ weapons: Weapons) {
        collection.append(weapons)
    }
    
    func getAllData() -> [Weapons] {
        return collection
    }
    
    func getDataByIndex(index: Int) -> Weapons {
        return collection[index]
    }
    
    public func count() -> Int {
        return collection.count
    }
}
