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

class Weapons: NSObject {
    
    var weaponId: Int
    var detailId: Int
    var weaponParentId: Int
    var weaponName: String
    var weaponColor: Int
    var weaponImg: String
    
    override init() {
        weaponId = 0
        detailId = 0
        weaponParentId = 0
        weaponName = ""
        weaponColor = 0
        weaponImg = ""
        
        super.init()
    }
    
    init(weaponId: Int, detailId: Int, weaponParentId: Int, weaponName: String, weaponColor: Int, weaponImg: String) {
        
        self.weaponId = weaponId
        self.detailId = detailId
        self.weaponParentId = weaponParentId
        self.weaponName = weaponName
        self.weaponColor = weaponColor
        self.weaponImg = weaponImg
    }
    
    override var description: String {
        
        get {
            let newDescription: String = "Model for weapons"
            
            return newDescription
        }
    }
}
