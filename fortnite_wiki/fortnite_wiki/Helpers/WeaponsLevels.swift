//
//  WeaponsLevels.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 07.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import ChameleonFramework

class WeaponsLevels: NSObject {
    
    struct levels {
        var grey = 0
        var green = 1
        var blue = 2
        var purple = 3
        var gold = 4
    }
}

class UIBackgroundView: NSObject {

    let shadows = ShadowLayers()
    let color0 = [HexColor("969696")!, HexColor("4A4A4A")!]
    let color1 = [HexColor("69E41A")!, HexColor("037E00")!]
    let color2 = [HexColor("00BFFF")!, HexColor("005999")!]
    let color3 = [HexColor("D257FF")!, HexColor("530080")!]
    let color4 = [HexColor("FFD528")!, HexColor("805600")!]

    func formatUIBackgroundViewFromLevel(view : UIView, level: Int) {
        
        switch level {
        case 0:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color0)
            break
        case 1:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color1)
            break
        case 2:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color2)
            break
        case 3:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color3)
            break
        case 4:
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color4)
            break
        default :
            view.backgroundColor = GradientColor(UIGradientStyle.radial, frame: view.frame, colors: color1)
            break
        }
        
        view.layer.borderWidth = 8.5
        view.layer.borderColor = UIColor.flatWhite.cgColor
        shadows.setLayer(view: view)
    }
    
    override var description: String {
        get {
            let newDescription = "Formater for UIBackground"
            return newDescription
        }
    }
}
