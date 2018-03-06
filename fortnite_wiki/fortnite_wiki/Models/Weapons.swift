//
//  Weapons.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class Weapons: NSObject {
    
    var weaponId: Int
    var weaponName: String
    var weaponColor: String
    var weaponImg: String
    
    var damage: Int
    var criticalHitChance: Int
    var criticalHitDmg: Int
    var fireRate: Float
    var magazineSize: Int
    var range: Int
    var durability: Int
    var reloadTime: Float
    var ammoCost: Int
    var impact: Int
    
    var spreadBase: Float
    var spreadSprint: Float
    var spreadJump: Float
    var spreadDownsights: Float
    var spreadStanding: Float
    var spreadCrouching: Float
    
    var firingRateNormal: Float
    var firingRateBurst: Float
    
    var environementDamage: Float
    var impactDamage: Float
    
    var recoilHorizontal: Float
    var recoilVertical: Float
    var recoilMaxAngle: Float
    var recoilMinAngle: Float
    var recoilDownsights: Float
    
    override init() {
        weaponId = 0
        weaponName = ""
        weaponColor = "grey"
        weaponImg = ""
        
        damage = 0
        criticalHitChance = 0
        criticalHitDmg = 0
        fireRate = 0.0
        magazineSize = 0
        range = 0
        durability = 0
        reloadTime = 0.0
        ammoCost = 0
        impact = 0
        
        spreadBase = 0.0
        spreadSprint = 0.0
        spreadJump = 0.0
        spreadDownsights = 0.0
        spreadStanding = 0.0
        spreadCrouching = 0.0
        firingRateNormal = 0.0
        firingRateBurst = 0.0
        environementDamage = 0.0
        impactDamage = 0.0
        recoilHorizontal = 0.0
        recoilVertical = 0.0
        recoilMaxAngle = 0.0
        recoilMinAngle = 0.0
        recoilDownsights = 0.0
        
        super.init()
    }
    
    init(weaponId: Int, weaponName: String, weaponColor: String, weaponImg: String, damage: Int, criticalHitChance: Int, criticalHitDmg: Int, fireRate: Float, magazineSize: Int, range: Int, durability: Int, reloadTime: Float, ammoCost: Int, impact: Int, spreadBase: Float, spreadSprint: Float, spreadJump: Float, spreadDownsights: Float, spreadStanding: Float, spreadCrouching: Float, firingRateNormal: Float, firingRateBurst: Float, environementDamage: Float, impactDamage: Float, recoilHorizontal: Float, recoilVertical: Float, recoilMaxAngle: Float, recoilMinAngle: Float, recoilDownsights: Float) {
        self.weaponId = weaponId
        self.weaponName = weaponName
        self.weaponColor = weaponColor
        self.weaponImg = weaponImg
        
        self.damage = damage
        self.criticalHitChance = criticalHitChance
        self.criticalHitDmg = criticalHitDmg
        self.fireRate = fireRate
        self.magazineSize = magazineSize
        self.range = range
        self.durability = durability
        self.reloadTime = reloadTime
        self.ammoCost = ammoCost
        self.impact = impact
        
        self.spreadBase = spreadBase
        self.spreadSprint = spreadSprint
        self.spreadJump = spreadJump
        self.spreadDownsights = spreadDownsights
        self.spreadStanding = spreadStanding
        self.spreadCrouching = spreadCrouching
        
        self.firingRateNormal = firingRateNormal
        self.firingRateBurst = firingRateBurst
        
        self.environementDamage = environementDamage
        self.impactDamage = impactDamage
        
        self.recoilHorizontal = recoilHorizontal
        self.recoilVertical = recoilVertical
        self.recoilMaxAngle = recoilMaxAngle
        self.recoilMinAngle = recoilMinAngle
        self.recoilDownsights = recoilDownsights
    }
    
    override var description: String {
        
        get {
            let newDescription: String = "Model for weapons"
            
            return newDescription
        }
    }
}
