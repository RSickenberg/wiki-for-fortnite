//
//  DetailsItemViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 12.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import ChameleonFramework
import StatusAlert

class DetailsItemViewController: UIViewController {

    // MARK: - Declarations

    let shadows = ShadowLayers()
    let colors = BackgroundColors()
    let BackgroundFormater = FormatLevels()
    let likeAlert = StatusAlert.instantiate(
        withImage: #imageLiteral(resourceName: "heartFullHighRes"),
        title: "We love you too !",
        message: "You can see your favorite on the other tab.",
        canBePickedOrDismissed: true
    )
    let dontLike = StatusAlert.instantiate(
        withImage: #imageLiteral(resourceName: "DislikeFullHighRes"),
        title: "It's okay.",
        message: "You can check other stuff.",
        canBePickedOrDismissed: true
    )
    let likeStorage = UserDefaults()

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var backgroundImageView: UIView!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    @IBAction func likeButton(_ sender: UIBarButtonItem) {
        if likeButtonState! { // Not enabled
            dontLike.showInKeyWindow()
            likeButton.image = #imageLiteral(resourceName: "loveIconEmpty")
            likeButtonState = false
            likeStorage.removeObject(forKey: "item_like_\(itemInfo.id)")
        }
        else { // Enabled
            likeAlert.showInKeyWindow()
            likeButton.image = #imageLiteral(resourceName: "loveIconFull")
            likeButtonState = true
            likeStorage.set(true, forKey: "item_like_\(itemInfo.id)")
        }
    }

    // MARK: - Outlets
    
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

    // MARK: - Declarations

    var index: Int = 0
    var itemInfo = Items()
    var itemDetails = ItemsDetails()
    var itemModel = JsonService.list
    var likeButtonState: Bool?

    override func viewDidLoad() {
        likeButtonState = false
        prepareVisuals()
        getGradientValueForBackgroundImage()
        styleLabels()
        displayValues()
        getLikeStorage()
    }

    // MARK: - Data

    func getLikeStorage() {
        if likeStorage.bool(forKey: "item_like_\(itemInfo.id)") {
            likeButton.image = #imageLiteral(resourceName: "loveIconFull")
            likeButtonState = true
        }
    }

    // MARK: - Visuals

    private func backgroundGradient() {
        colors.backgroundGradient(view: view)
    }

    private func getGradientValueForBackgroundImage() {
        BackgroundFormater.formatUIBackgroundViewFromLevel(view: backgroundImageView, level: itemInfo.color)
        shadows.setShadow(image: itemImage)
    }

    private func styleLabels() {
        let labels = [overallTitle, overallStackedTitle1, overallStackedTitle2, overallStackedTitle3, overallStackedValue1, overallStackedValue2, overallStackedValue3, detailsStackedTitle1, detailsStackedTitle2, detailsStackedTitle3, detailsTitle, detailsStackedValue1, detailsStackedValue2, detailsStackedValue3]
        for label in labels {
            shadows.setShadow(label: label!)
        }
    }
    
    private func prepareVisuals() {
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
            }
            else {
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
        }
        else {
            detailsStackedTitle3.isHidden = true
            detailsStackedValue3.isHidden = true
        }
    }
}
