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

    let shadows = ShadowLayers()
    let colors = BackgroundColors()
    let BackgroundFormater = FormatLevels()

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var backgroundImageView: UIView!
    
    //////////////////////////////////////////////////////////
    
    @IBOutlet weak var overallTitle: UILabel!
    @IBOutlet weak var overallStackedTitle1: UILabel!
    @IBOutlet weak var overallStackedTitle2: UILabel!
    @IBOutlet weak var overallStackedTitle3: UILabel!
    ///////////
    @IBOutlet weak var overallStackedValue1: UILabel!
    @IBOutlet weak var overallStackedValue2: UILabel!
    @IBOutlet weak var overallStackedValue3: UILabel!
    
    //////////////////////////////////////////////////////////
    
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsStackedTitle1: UILabel!
    @IBOutlet weak var detailsStackedTitle2: UILabel!
    @IBOutlet weak var detailsStackedTitle3: UILabel!
    ///////////
    @IBOutlet weak var detailsStackedValue1: UILabel!
    @IBOutlet weak var detailsStackedValue2: UILabel!
    @IBOutlet weak var detailsStackedValue3: UILabel!
    

    var index: Int = 0
    var itemInfo = Items()
    var itemDetails = ItemsDetails()
    var itemModel = DetailsForObjects()

    override func viewDidLoad() {
        backgroundGradient()
        itemImage.image = UIImage(named: itemInfo.itemImg)
        titleView.title = itemInfo.itemName
        getGradientValueForBackgroundImage()
        
        styleLabels()
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func getGradientValueForBackgroundImage() {
        BackgroundFormater.formatUIBackgroundViewFromLevel(view: backgroundImageView, level: itemInfo.itemColor)
        shadows.setShadow(image: itemImage)
    }
    
    func styleLabels() {
        let labels = [overallTitle,overallStackedTitle1,overallStackedTitle2,overallStackedTitle3,overallStackedValue1,overallStackedValue2,overallStackedValue3,detailsStackedTitle1,detailsStackedTitle2,detailsStackedTitle3,detailsTitle,detailsStackedValue1,detailsStackedValue2,detailsStackedValue3]
        for label in labels {
            shadows.setShadow(label: label!)
        }
    }
    
}
