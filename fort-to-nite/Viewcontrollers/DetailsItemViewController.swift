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
    let likeStorage = UserDefaults()
    
    struct likeActions {
        let like: Bool
        let dislike: Bool
    }

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleView: UINavigationItem!
    @IBOutlet weak var backgroundImageView: UIView!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    @IBAction func likeButton(_ sender: UIBarButtonItem) {
        if likeButtonState! { // Not enabled
            let dontLikeAlert = StatusAlert()
            statusAlert(statusAlertInstance: dontLikeAlert, action: likeActions(like: false, dislike: true))
            dontLikeAlert.showInKeyWindow()
            likeButton.image = #imageLiteral(resourceName: "loveIconEmpty")
            likeButtonState = false
            likeStorage.removeObject(forKey: "item_like_\(itemInfo.id)")
        }
        else { // Enabled
            let likeAlert = StatusAlert()
            statusAlert(statusAlertInstance: likeAlert, action: likeActions(like: true, dislike: false))
            likeAlert.showInKeyWindow()
            likeButton.image = #imageLiteral(resourceName: "loveIconFull")
            likeButtonState = true
            likeStorage.set(true, forKey: "item_like_\(itemInfo.id)")
        }
    }

    var index: Int = 0
    var itemInfo = Items()
    var itemDetails = ItemsDetails()
    var itemModel = JsonService.list
    var likeButtonState: Bool?

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

    override func viewDidLoad() {
        likeButtonState = false
        prepareVisuals()
        displayValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        getLikeStorage()
    }

    // MARK: - Data

    func getLikeStorage() {
        if likeStorage.bool(forKey: "item_like_\(itemInfo.id)") {
            likeButton.image = #imageLiteral(resourceName: "loveIconFull")
            likeButtonState = true
        } else {
            likeButton.image = #imageLiteral(resourceName: "loveIconEmpty")
            likeButtonState = false
        }
    }

    // MARK: - Visuals

    private func backgroundGradient() {
        BackgroundColors().backgroundGradient(view: view)
    }

    private func getGradientValueForBackgroundImage() {
        FormatLevels().formatUIBackgroundViewFromLevel(view: backgroundImageView, level: itemInfo.color)
        shadows.setShadow(image: itemImage)
    }

    private func styleLabels() {
        let labels = [overallTitle, overallStackedTitle1, overallStackedTitle2, overallStackedTitle3, overallStackedValue1, overallStackedValue2, overallStackedValue3, detailsStackedTitle1, detailsStackedTitle2, detailsStackedTitle3, detailsTitle, detailsStackedValue1, detailsStackedValue2, detailsStackedValue3]
        for label in labels {
            shadows.setShadow(label: label!)
        }
    }
    
    private func statusAlert(statusAlertInstance: StatusAlert, action: likeActions) {
        if action.like {
            statusAlertInstance.appearance.titleFont = UIFont(name: "BurbankBigCondensed-bold", size: 23)!
            statusAlertInstance.appearance.messageFont = UIFont(name: "BurbankBigCondensed-bold", size: 16)!
            statusAlertInstance.image = #imageLiteral(resourceName: "heartFullHighRes2")
            statusAlertInstance.title = "It's liked!"
            statusAlertInstance.message = "You can see your favorites on the more tab."
            statusAlertInstance.canBePickedOrDismissed = true
            statusAlertInstance.alertShowingDuration = TimeInterval(exactly: 2)!
        }
        if action.dislike {
            statusAlertInstance.appearance.titleFont = UIFont(name: "BurbankBigCondensed-bold", size: 23)!
            statusAlertInstance.appearance.messageFont = UIFont(name: "BurbankBigCondensed-bold", size: 16)!
            statusAlertInstance.image = #imageLiteral(resourceName: "DislikeFullHighRes")
            statusAlertInstance.title = "It's okay."
            statusAlertInstance.message = "You can check other stuff."
            statusAlertInstance.canBePickedOrDismissed = true
            statusAlertInstance.alertShowingDuration = TimeInterval(exactly: 2)!
        }
    }
    
    private func prepareVisuals() {
        StatusAlert.multiplePresentationsBehavior = .dismissCurrentlyPresented
        backgroundGradient()
        getGradientValueForBackgroundImage()
        styleLabels()
        itemModel.setImageByItemId(itemInfo.id, imageView: itemImage)
        titleView.title = itemInfo.name
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: - Values

    private func displayValues() {
        let details = itemDetails
        
        if (details.isExplosive) {
            if (details.damages != 0) {
                overallStackedTitle1.text = "Damages"
                overallStackedValue1.text = String(details.damages)
            }
            else {
                overallStackedTitle1.isHidden = true
                overallStackedValue1.isHidden = true
            }
            
            overallStackedTitle2.isHidden = true
            overallStackedValue2.isHidden = true
            
            if (details.capacity != 0) {
                overallStackedTitle3.text = "Capacity"
                overallStackedValue3.text = String(details.capacity)
            }
            else {
                overallStackedTitle3.text = "Capacity"
                overallStackedValue3.text = "No limit"
            }
            
            detailsStackedTitle1.isHidden = true
            detailsStackedValue1.isHidden = true
            
            detailsStackedTitle2.text = "Locations"
            detailsStackedValue2.text = details.location
        }
        
        if (details.isHeal) {
            if details.shield != 0 && details.heal != 0 {
                overallStackedTitle1.text = "Shield"
                overallStackedValue1.text = String(details.shield)
                overallStackedTitle2.text = "Heal"
                overallStackedValue2.text = String(details.heal)
            }
            else if details.shield == 0 && details.heal != 0 {
                overallStackedTitle1.isHidden = true
                overallStackedValue1.isHidden = true
                overallStackedTitle2.text = "Heal"
                overallStackedValue2.text = String(details.heal)
            }
            else if details.heal == 0 && details.shield != 0 {
                overallStackedTitle1.text = "Shield"
                overallStackedValue1.text = String(details.shield)
                overallStackedTitle2.isHidden = true
                overallStackedValue2.isHidden = true
            }
            
            if (details.capacity != 0) {
                overallStackedTitle3.text = "Capacity"
                overallStackedValue3.text = String(details.capacity)
            } else {
                overallStackedTitle3.text = "Capacity"
                overallStackedValue3.text = "No limit"
            }
            
            detailsStackedTitle1.text = "Delay"
            detailsStackedValue1.text = String(details.delay) + "s"
            
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
