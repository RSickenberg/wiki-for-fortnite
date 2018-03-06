//
//  Items.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class Items: NSObject {
    
    var ItemsList = [Int:String]()
    
    override init() {
        super.init()
        
        ItemsList = [0:"nil"]
    }
    
    // Init with demo data
}
