//
//  DetailsForObject.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 06.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//  README: You need to add only one weapon for all of his levels like (AR + Details for Grey level) -> (Details for green level) -> (Details for blue level) /!\ DON'T FORGET THE WEAPONID TO MATCH THE DETAILS WITH THE WEAPON
//          Grey : color 0 / detailLevel 0
//          Green : color 1 / detailLevel 1
//          Blue : color 2 / detailLevel 2
//          Purple : color 3 / detailLevel 3
//          Gold :  color 4 / detailLevel 4
//
//
//  Since 3.4, weapons can have dissociated style, or colors, like: green / blue
//  For new methods, please, take note of this.

import Foundation

class DetailsForObjects: NSObject {
    
    private var weaponsCollection = [Weapons]()
    private var weaponsDetails = [WeaponsDetails]()
    
    private var itemsCollection = [Items]()
    private var itemsDetails = [ItemsDetails]()
    
    override init() {
        super.init()
        
        self.loadWeaponsDemoData()
    }
    
    func loadWeaponsDemoData() {
        var weaponsData = Weapons()
        var weaponsDetails = WeaponsDetails()
        
        weaponsData.weaponId = 0
        weaponsData.detailId = 0
        weaponsData.weaponParentId = 0
        weaponsData.weaponName = "Assault Riffle (burst)"
        weaponsData.weaponColor = 0
        weaponsData.weaponImg = "ar_burst"
        
        weaponsDetails.detailLevel = 0
        weaponsDetails.weaponId = 0
        weaponsDetails.damage = 27
        weaponsDetails.damageHead = 67.5
        weaponsDetails.criticalHitChance = 0
        weaponsDetails.criticalHitDmg = 0
        weaponsDetails.fireRate = 4.06
        weaponsDetails.magazineSize = 30
        weaponsDetails.range = 1
        weaponsDetails.durability = 100
        weaponsDetails.reloadTime = 2.9
        weaponsDetails.ammoCost = 1
        weaponsDetails.impact = 40
        weaponsDetails.spreadBase = 0.175
        weaponsDetails.spreadSprint = 1.5
        weaponsDetails.spreadJump = 1.25
        weaponsDetails.spreadDownsights = 0.65
        weaponsDetails.spreadStanding = 0.55
        weaponsDetails.spreadCrouching = 0.75
        weaponsDetails.firingRateNormal = 4.06
        weaponsDetails.firingRateBurst = 12
        weaponsDetails.environementDamage = 30
        weaponsDetails.impactDamage = 40
        weaponsDetails.recoilHorizontal = 0.25
        weaponsDetails.recoilVertical = 1.925
        weaponsDetails.recoilMaxAngle = 25
        weaponsDetails.recoilMinAngle = -25
        weaponsDetails.recoilDownsights = 0.5
        
        self.addToDB(weaponsData)
        self.addDetailsToDB(weaponsDetails)
        
        weaponsDetails = WeaponsDetails()
        
        weaponsDetails.detailLevel = 1
        weaponsDetails.weaponId = 0
        weaponsDetails.damage = 29
        weaponsDetails.damageHead = 72.5
        weaponsDetails.criticalHitChance = 0
        weaponsDetails.criticalHitDmg = 0
        weaponsDetails.fireRate = 4.06
        weaponsDetails.magazineSize = 30
        weaponsDetails.range = 1
        weaponsDetails.durability = 100
        weaponsDetails.reloadTime = 2.7
        weaponsDetails.ammoCost = 1
        weaponsDetails.impact = 42
        weaponsDetails.spreadBase = 0.175
        weaponsDetails.spreadSprint = 1.5
        weaponsDetails.spreadJump = 1.25
        weaponsDetails.spreadDownsights = 0.65
        weaponsDetails.spreadStanding = 0.55
        weaponsDetails.spreadCrouching = 0.75
        weaponsDetails.firingRateNormal = 4.06
        weaponsDetails.firingRateBurst = 12
        weaponsDetails.environementDamage = 30
        weaponsDetails.impactDamage = 42
        weaponsDetails.recoilHorizontal = 0.25
        weaponsDetails.recoilVertical = 1.8375
        weaponsDetails.recoilMaxAngle = 25
        weaponsDetails.recoilMinAngle = -25
        weaponsDetails.recoilDownsights = 0.5
        
        self.addDetailsToDB(weaponsDetails)
        
        weaponsDetails = WeaponsDetails()

        weaponsDetails.detailLevel = 2
        weaponsDetails.weaponId = 0
        weaponsDetails.damage = 30
        weaponsDetails.damageHead = 75
        weaponsDetails.criticalHitChance = 0
        weaponsDetails.criticalHitDmg = 0
        weaponsDetails.fireRate = 4.06
        weaponsDetails.magazineSize = 30
        weaponsDetails.range = 1
        weaponsDetails.durability = 100
        weaponsDetails.reloadTime = 2.6
        weaponsDetails.ammoCost = 1
        weaponsDetails.impact = 44
        weaponsDetails.spreadBase = 0.175
        weaponsDetails.spreadSprint = 1.5
        weaponsDetails.spreadJump = 1.25
        weaponsDetails.spreadDownsights = 0.65
        weaponsDetails.spreadStanding = 0.55
        weaponsDetails.spreadCrouching = 0.75
        weaponsDetails.firingRateNormal = 4.06
        weaponsDetails.firingRateBurst = 12
        weaponsDetails.environementDamage = 30
        weaponsDetails.impactDamage = 44
        weaponsDetails.recoilHorizontal = 0.25
        weaponsDetails.recoilVertical = 1.75
        weaponsDetails.recoilMaxAngle = 25
        weaponsDetails.recoilMinAngle = -25
        weaponsDetails.recoilDownsights = 0.5
        
        self.addDetailsToDB(weaponsDetails)
        
        weaponsData = Weapons()
        weaponsDetails = WeaponsDetails()
        
        weaponsData.weaponId = 3
        weaponsData.detailId = 3
        weaponsData.weaponParentId = 3
        weaponsData.weaponName = "Assault Riffle (SCAR)"
        weaponsData.weaponColor = 3
        weaponsData.weaponImg = "ar_scar"
        
        weaponsDetails.detailLevel = 3
        weaponsDetails.weaponId = 3
        weaponsDetails.damage = 35
        weaponsDetails.damageHead = 70
        weaponsDetails.criticalHitChance = 0
        weaponsDetails.criticalHitDmg = 0
        weaponsDetails.fireRate = 5.5
        weaponsDetails.magazineSize = 30
        weaponsDetails.range = 1
        weaponsDetails.durability = 100
        weaponsDetails.reloadTime = 2.1
        weaponsDetails.ammoCost = 1
        weaponsDetails.impact = 29
        weaponsDetails.spreadBase = 0.15
        weaponsDetails.spreadSprint = 1.5
        weaponsDetails.spreadJump = 1.25
        weaponsDetails.spreadDownsights = 0.6
        weaponsDetails.spreadStanding = 0.55
        weaponsDetails.spreadCrouching = 0.8
        weaponsDetails.firingRateNormal = 5.5
        weaponsDetails.firingRateBurst = 5
        weaponsDetails.environementDamage = 33
        weaponsDetails.impactDamage = 29
        weaponsDetails.recoilHorizontal = 0.25
        weaponsDetails.recoilVertical = 3.237
        weaponsDetails.recoilMaxAngle = 25
        weaponsDetails.recoilMinAngle = -25
        weaponsDetails.recoilDownsights = 0.5
        
        self.addToDB(weaponsData)
        self.addDetailsToDB(weaponsDetails)
        
        weaponsDetails = WeaponsDetails()
        
        weaponsDetails.detailLevel = 4
        weaponsDetails.weaponId = 3
        weaponsDetails.damage = 36
        weaponsDetails.damageHead = 72
        weaponsDetails.criticalHitChance = 0
        weaponsDetails.criticalHitDmg = 0
        weaponsDetails.fireRate = 5.5
        weaponsDetails.magazineSize = 30
        weaponsDetails.range = 1
        weaponsDetails.durability = 100
        weaponsDetails.reloadTime = 2.1
        weaponsDetails.ammoCost = 1
        weaponsDetails.impact = 31
        weaponsDetails.spreadBase = 0.15
        weaponsDetails.spreadSprint = 1.5
        weaponsDetails.spreadJump = 1.25
        weaponsDetails.spreadDownsights = 0.6
        weaponsDetails.spreadStanding = 0.55
        weaponsDetails.spreadCrouching = 0.8
        weaponsDetails.firingRateNormal = 5.5
        weaponsDetails.firingRateBurst = 5
        weaponsDetails.environementDamage = 33
        weaponsDetails.impactDamage = 31
        weaponsDetails.recoilHorizontal = 0.25
        weaponsDetails.recoilVertical = 3.15
        weaponsDetails.recoilMaxAngle = 25
        weaponsDetails.recoilMinAngle = -25
        weaponsDetails.recoilDownsights = 0.5
        
        self.addDetailsToDB(weaponsDetails)
    }
    
    func addToDB(_ weapons: Weapons) {
        weaponsCollection.append(weapons)
    }
    
    func addDetailsToDB(_ details: WeaponsDetails) {
        weaponsDetails.append(details)
    }
    
    func getAllWeapons() -> [Weapons] {
        return weaponsCollection
    }
    
    func getAllWeaponsDetails() -> [WeaponsDetails] {
        return weaponsDetails
    }
    
    func getWeaponsByIndex(index: Int) -> Weapons {
        return weaponsCollection[index]
    }
    
    func countWeapons() -> Int {
        return weaponsCollection.count
    }
    
    func getDetailsByWeaponId(weaponId: Int) -> WeaponsDetails {
        let key = weaponsDetails.index(where: { $0.weaponId == weaponId })
        
        return weaponsDetails[key!]
    }
    
    func getDetailsByWeaponIdAndLevel(weaponId: Int, weaponLevel: Int) -> WeaponsDetails {
        let key = weaponsDetails.index(where: { $0.weaponId == weaponId && $0.detailLevel == weaponLevel })
    
        return weaponsDetails[key!]
    }
    
    func countNumberOfLevelsByWeaponId(_ weaponId: Int) -> Int {
        var numberOfLevels: Int = 0
        
        for detail in weaponsDetails {
            if detail.weaponId == weaponId {
                numberOfLevels += 1
            }
        }
        
        return numberOfLevels
    }
    
    func getLevelsByWeaponId(_ weaponId: Int) -> [Int] {
        var levels = [Int]()
        
        for detail in weaponsDetails {
            if detail.weaponId == weaponId {
                levels.append(detail.detailLevel)
            }
        }
        
        return levels
    }
    
}
