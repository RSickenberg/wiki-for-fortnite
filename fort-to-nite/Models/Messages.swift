//
//  Messages.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 5.08.19.
//  Copyright © 2019 Romain Sickenberg. All rights reserved.
//

import Foundation

class Messages: Codable {
    private var storedDate: Date?
    private var storedHash: String?

    var date: String?
    var data: String?

    var hash: String {
        get {
            return storedHash ?? ""
        }
        set(value) {
            storedHash = value
        }
    }

    var cleanDate : Date? {
        get {
            return storedDate
        }
        set(value) {
            storedDate = value
        }
    }
    
    init() {
        date = nil
        data = nil
    }
    
    init(date: String, data: String) {
        self.date = date
        self.data = data
    }
}
