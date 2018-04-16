//
//  shadowLayers.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 06.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import UIKit

class ShadowLayers: NSObject {
    
    var shadowColor: CGColor
    var shadowRadius: CGFloat
    var shadowOpacity: Float
    var shadowOffset: CGSize
    var maskToBounds: Bool
    
    override init() {
        shadowColor = UIColor.black.cgColor
        shadowRadius = 2.1
        shadowOpacity = 0.8
        shadowOffset = CGSize(width: 0, height: 0)
        maskToBounds = false
    }
    
    init(shadowColor: CGColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffset: CGSize, maskToBounds: Bool) {
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.maskToBounds = maskToBounds
    }
    
    func setLayer(label: UILabel) {
        label.layer.shadowColor = shadowColor
        label.layer.shadowRadius = shadowRadius
        label.layer.shadowOpacity = shadowOpacity
        label.layer.shadowOffset = shadowOffset
    }
    
    func setLayer(view: UIView) {
        view.layer.shadowColor = shadowColor
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = shadowOffset
    }
    
    func setLayer(image: UIImageView) {
        image.layer.shadowColor = shadowColor
        image.layer.shadowRadius = shadowRadius
        image.layer.shadowOpacity = shadowOpacity
        image.layer.shadowOffset = shadowOffset
    }

    func setLayer(cell: UICollectionViewCell) {
        cell.layer.shadowColor = shadowColor
        cell.layer.shadowRadius = shadowRadius
        cell.layer.shadowOpacity = shadowOpacity
        cell.layer.shadowOffset = shadowOffset

        cell.layer.cornerRadius = 6.5
    }
    
    override var description: String {
        get {
            let newDescription: String = "Helper for Shadows values"
            
            return newDescription
        }
    }
}
