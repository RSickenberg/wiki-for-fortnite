//
//  GradientView.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 3.12.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        guard let layer = self.layer as? CAGradientLayer else {
            return
        }
        
        layer.colors = [UIColor(red: 55.0 / 255.0, green: 194.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 110.0 / 255.0, green: 50.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0).cgColor]
        layer.locations = [0.0, 1.0]
        layer.frame = self.bounds
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
