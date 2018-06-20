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

    /////////////////////////////////////////////////////////

    var index: Int = 0
    var itemInfo = Items()
    var itemDetails = ItemsDetails()
    var itemModel = JsonService.list

    override func viewDidLoad() {
        prepareVisuals()
        getGradientValueForBackgroundImage()
        styleLabels()
        displayValues()
    }

    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }

    func getGradientValueForBackgroundImage() {
        BackgroundFormater.formatUIBackgroundViewFromLevel(view: backgroundImageView, level: itemInfo.color)
        shadows.setShadow(image: itemImage)
    }

    func styleLabels() {
        let labels = [overallTitle, overallStackedTitle1, overallStackedTitle2, overallStackedTitle3, overallStackedValue1, overallStackedValue2, overallStackedValue3, detailsStackedTitle1, detailsStackedTitle2, detailsStackedTitle3, detailsTitle, detailsStackedValue1, detailsStackedValue2, detailsStackedValue3]
        for label in labels {
            shadows.setShadow(label: label!)
        }
    }
    
    func prepareVisuals() {
        backgroundGradient()
        itemModel.setImageByItemId(itemInfo.id, imageView: itemImage)
        titleView.title = itemInfo.name
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    func displayValues() {
        let details = itemDetails
        
        if (details.isExplosive) {
            overallStackedTitle1.text = "Damages"
            overallStackedValue1.text = String(details.damages)
            
            overallStackedTitle2.isHidden = true
            overallStackedValue2.isHidden = true
            
            overallStackedTitle3.text = "Capacity"
            overallStackedValue3.text = String(details.capacity)
            
            detailsStackedTitle1.isHidden = true
            detailsStackedValue1.isHidden = true
            
            detailsStackedTitle2.text = "Locations"
            detailsStackedValue2.text = details.location
        }
        
        if (details.isHeal) {
            if (details.shield != 0) {
                overallStackedTitle1.text = "Shield"
                overallStackedValue1.text = String(details.shield)
            } else {
                overallStackedTitle1.text = "Heal"
                overallStackedValue1.text = String(details.heal)
            }
            
            overallStackedTitle2.text = "Delay"
            overallStackedValue2.text = String(details.delay) + "s"
            
            overallStackedTitle3.text = "Capacity"
            overallStackedValue3.text = String(details.capacity)
            
            detailsStackedTitle1.isHidden = true
            detailsStackedValue1.isHidden = true
            
            detailsStackedTitle2.text = "Locations"
            detailsStackedValue2.text = details.location
        }
        
        if (details.comment != "") {
            detailsStackedTitle3.text = "Note"
            detailsStackedValue3.text = details.comment
        } else {
            detailsStackedTitle3.isHidden = true
            detailsStackedValue3.isHidden = true
        }
    }
}
