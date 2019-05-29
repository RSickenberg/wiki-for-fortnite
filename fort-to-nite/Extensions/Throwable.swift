//
//  Throwable.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 29.05.19.
//  Copyright © 2019 Romain Sickenberg. All rights reserved.
//

import Foundation

extension Throwable {
    var value: T? {
        switch self {
        case .failure(let error):
            return error as? T
        case .success(let value):
            return value
        }
    }
}
