//
//  shadowLayers.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 06.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class ShadowLayers {

    var shadowColor: CGColor
    var shadowRadius: CGFloat
    var shadowOpacity: Float
    var shadowOffset: CGSize
    var maskToBounds: Bool

    init() {
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

    func setShadow(label: UILabel) {
        label.layer.shadowColor = shadowColor
        label.layer.shadowRadius = shadowRadius
        label.layer.shadowOpacity = shadowOpacity
        label.layer.shadowOffset = shadowOffset
    }

    func setShadow(view: UIView) {
        view.layer.shadowColor = shadowColor
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = shadowOffset
    }

    func setShadow(image: UIImageView) {
        image.layer.shadowColor = shadowColor
        image.layer.shadowRadius = shadowRadius
        image.layer.shadowOpacity = shadowOpacity
        image.layer.shadowOffset = shadowOffset
    }

    func setShadow(cell: UICollectionViewCell) {
        cell.layer.shadowColor = shadowColor
        cell.layer.shadowRadius = shadowRadius
        cell.layer.shadowOpacity = shadowOpacity
        cell.layer.shadowOffset = shadowOffset

        cell.layer.cornerRadius = 7.0
    }
    
    func setGradientShadow(cell: UIView) {
        cell.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: cell.frame, colors: [UIColor.clear, UIColor.clear, UIColor.flatBlack()])
    }
    
}
