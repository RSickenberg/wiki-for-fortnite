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
        
        switch itemInfo.itemColor {
        case 0 :
            backgroundImageView.backgroundColor = GradientColor(UIGradientStyle.radial, frame: backgroundImageView.frame, colors: [UIColor.init(hexString: "B0B0B0")!, UIColor.init(hexString: "7D7D7D")!])
            break
        case 1 :
            backgroundImageView.backgroundColor = GradientColor(UIGradientStyle.radial, frame: backgroundImageView.frame, colors: [UIColor.init(hexString: "69E41A")!, UIColor.init(hexString: "1C9700")!])
            break
        case 2 :
            backgroundImageView.backgroundColor = GradientColor(UIGradientStyle.radial, frame: backgroundImageView.frame, colors: [UIColor.init(hexString: "1AD9FF")!, UIColor.init(hexString: "0073B3")!])
            break
        case 3 :
            backgroundImageView.backgroundColor = GradientColor(UIGradientStyle.radial, frame: backgroundImageView.frame, colors: [UIColor.init(hexString: "D257FF")!, UIColor.init(hexString: "9F24D9")!])
            break
        case 4 :
            backgroundImageView.backgroundColor = GradientColor(UIGradientStyle.radial, frame: backgroundImageView.frame, colors: [UIColor.init(hexString: "FFD528")!, UIColor.init(hexString: "CDA200")!])
            break
        default:
            break
        }
        
        backgroundImageView.layer.borderWidth = 8.5
        backgroundImageView.layer.borderColor = UIColor.flatWhite.cgColor
        
        shadows.setLayer(view: backgroundImageView)
        shadows.setLayer(image: itemImage)
    }
    
}
