//
//  WeaponsDetails.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 07.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class WeaponsDetails: NSObject, Decodable {

    var detailLevel: Int
    var weaponId: Int
    var damage: Int
    var damageHead: Float
    var fireRate: Float
    var magazineSize: Int
    var reloadTime: Float
    var impact: Float
    
    var spreadBase: Float
    var spreadSprint: Float
    var spreadJump: Float
    var spreadDownsights: Float
    var spreadStanding: Float
    var spreadCrouching: Float
    
    var firingRateBurst: Float
    
    var environementDamage: Float
    
    var recoilHorizontal: Float
    var recoilVertical: Float
    var recoilMaxAngle: Float
    var recoilMinAngle: Float
    var recoilDownsights: Float
    
    override init() {
        detailLevel = 0
        weaponId = 0
        damage = 0
        damageHead = 0
        fireRate = 0.0
        magazineSize = 0
        reloadTime = 0.0
        impact = 0
        spreadBase = 0.0
        spreadSprint = 0.0
        spreadJump = 0.0
        spreadDownsights = 0.0
        spreadStanding = 0.0
        spreadCrouching = 0.0
        firingRateBurst = 0.0
        environementDamage = 0.0
        recoilHorizontal = 0.0
        recoilVertical = 0.0
        recoilMaxAngle = 0.0
        recoilMinAngle = 0.0
        recoilDownsights = 0.0
        
        super.init()
    }
    
    init(detailLevel:Int, weaponId: Int, damage: Int, damageHead: Float, fireRate: Float, magazineSize: Int, reloadTime: Float, impact: Float, spreadBase: Float, spreadSprint: Float, spreadJump: Float, spreadDownsights: Float, spreadStanding: Float, spreadCrouching: Float, firingRateBurst: Float, environementDamage: Float, recoilHorizontal: Float, recoilVertical: Float, recoilMaxAngle: Float, recoilMinAngle: Float, recoilDownsights: Float) {

        self.detailLevel = detailLevel
        self.weaponId = weaponId
        self.damage = damage
        self.damageHead = damageHead
        self.fireRate = fireRate
        self.magazineSize = magazineSize
        self.reloadTime = reloadTime
        self.impact = impact
        
        self.spreadBase = spreadBase
        self.spreadSprint = spreadSprint
        self.spreadJump = spreadJump
        self.spreadDownsights = spreadDownsights
        self.spreadStanding = spreadStanding
        self.spreadCrouching = spreadCrouching
        
        self.firingRateBurst = firingRateBurst
        
        self.environementDamage = environementDamage
        
        self.recoilHorizontal = recoilHorizontal
        self.recoilVertical = recoilVertical
        self.recoilMaxAngle = recoilMaxAngle
        self.recoilMinAngle = recoilMinAngle
        self.recoilDownsights = recoilDownsights
    }
    
    override var description: String {
        
        get {
            let newDescription: String = "High details for Weapons"
            
            return newDescription
        }
    }
}
