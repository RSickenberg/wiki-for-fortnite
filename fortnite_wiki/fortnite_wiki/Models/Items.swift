//
//  Items.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation

class Items: NSObject {

    var itemId: Int
    var detailId: Int
    var itemName: String
    var itemColor: Int
    var itemImg: String

    override init() {
        itemId = 0
        detailId = 0
        itemName = ""
        itemColor = 0
        itemImg = ""
    }

    init(itemId: Int, detailId: Int, itemName: String, itemColor: Int, itemImg: String) {
        self.itemId = itemId
        self.detailId = detailId
        self.itemName = itemName
        self.itemColor = itemColor
        self.itemImg = itemImg
    }

    override var description: String {
        get {
            let newDescription: String = "Model for items"

            return newDescription
        }
    }
}
