//
//  Messages.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 5.08.19.
//  Copyright © 2019 Romain Sickenberg. All rights reserved.
//

import Foundation

struct Messages: Codable {
    var date: String?
    var data: String?
    var hash: String?
    var clearDate: Date?
    
    init() {
        date = nil
        data = nil
    }
    
    init(date: String, data: String) {
        self.date = date
        self.data = data
    }
}
