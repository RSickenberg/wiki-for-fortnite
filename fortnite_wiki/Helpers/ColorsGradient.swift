//
//  Colors.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//  TODO : Update this code with pod 'ChameleonFramework'
//

import Foundation
import UIKit

class BackgroundColors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 55.0 / 255.0, green: 194.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 115.0 / 255.0, green: 50.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}