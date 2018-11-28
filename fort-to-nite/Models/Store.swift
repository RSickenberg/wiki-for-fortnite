//
//  Store.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 15.11.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

//class Store: Codable {
//
//    var imageUrl: String
//    var manifestId: Int
//    var name: String
//    var rarity: String
//    var storeCategory: String
//    var vBucks: Int
//
//    init() {
//        imageUrl = ""
//        manifestId = 0
//        name = ""
//        rarity = ""
//        storeCategory = ""
//        vBucks = 0
//    }
//
//    init(imageUrl: String, manifestId: Int, name: String, rarity: String, storeCategory: String, vBucks: Int) {
//        self.imageUrl = imageUrl
//        self.manifestId = manifestId
//        self.name = name
//        self.rarity = rarity
//        self.storeCategory = storeCategory
//        self.vBucks = vBucks
//    }
//}

struct Store: Codable {
    var imageUrl: String
    var manifestId: Int
    var name: String
    var rarity: String
    var storeCategory: String
    var vBucks: Int
    
    init() {
        imageUrl = ""
        manifestId = 0
        name = ""
        rarity = ""
        storeCategory = ""
        vBucks = 0
    }
    
    init(imageUrl: String, manifestId: Int, name: String, rarity: String, storeCategory: String, vBucks: Int) {
        self.imageUrl = imageUrl
        self.manifestId = manifestId
        self.name = name
        self.rarity = rarity
        self.storeCategory = storeCategory
        self.vBucks = vBucks
    }
}
