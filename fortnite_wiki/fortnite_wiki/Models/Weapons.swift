//
//  Weapons.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class Weapons: NSObject {
    
    var WeaponsList = [Int:String]()
    
    override init() {
        super.init()
        
        WeaponsList = [0:"default"]
    }
}
