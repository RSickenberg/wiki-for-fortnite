//
//  DetailsItemViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 12.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import ChameleonFramework

class DetailsItemViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var backgroundImageView: UIView!
    let shadows = ShadowLayers()
    let colors = BackgroundColors()
    let BackgroundFormater = UIBackgroundView()
    var index: Int = 0
    var itemInfo = Items()
    var itemDetails = ItemsDetails()
    var itemModel = DetailsForObjects()
    
    override func viewDidLoad() {
        backgroundGradient()
        
        itemImage.image = UIImage(named: itemInfo.itemImg)
        titleView.title = itemInfo.itemName
        
        getGradientValueForBackgroundImage()
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func getGradientValueForBackgroundImage() {
        BackgroundFormater.formatUIBackgroundViewFromLevel(view: backgroundImageView, level: itemInfo.itemColor)
        shadows.setLayer(image: itemImage)
    }
    
}
