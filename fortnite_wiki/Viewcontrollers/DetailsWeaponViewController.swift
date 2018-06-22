//
//  DetailsViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//  TODO: Find a way to reduce all the calls inside the model
//

import UIKit
import ChameleonFramework
import StatusAlert

class DetailsWeaponViewController: UIViewController {

    let colors = BackgroundColors()
    let BackgroundFormatter = FormatLevels()
    let feedback = UISelectionFeedbackGenerator()
    let shadowOptions = ShadowLayers()
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
    var likeButtonState: Bool?

    @IBOutlet weak var titleNavigation: UINavigationItem!
    @IBOutlet weak var detailsViewTitle: UINavigationItem!
    @IBOutlet weak var levelOfWeaponSwitch: UISegmentedControl!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    @IBAction func likeButton(_ sender: UIBarButtonItem!) {
        if likeButtonState! { // Not enabled
            dontLike.showInKeyWindow()
            likeButton.image = #imageLiteral(resourceName: "loveIconEmpty")
            likeButtonState = false
            likeStorage.removeObject(forKey: "weapon_like_\(weaponInfo.id)")
        }
        else { // Enabled
            likeAlert.showInKeyWindow()
            likeButton.image = #imageLiteral(resourceName: "loveIconFull")
            likeButtonState = true
            likeStorage.set(true, forKey: "weapon_like_\(weaponInfo.id)")
        }
    }
    
    @IBAction func levelOfWeaponSwitch(_ sender: UISegmentedControl) {
        // Change level here
        feedback.selectionChanged()
        switch levelOfWeaponSwitch.titleForSegment(at: levelOfWeaponSwitch.selectedSegmentIndex)! {
        case "Common":
            BackgroundFormatter.formatUIBackgroundViewFromLevel(view: uiBackgroundView, level: 0)
            populateLabelsByValueAndLevels(0)
            break
        case "Atypical":
            BackgroundFormatter.formatUIBackgroundViewFromLevel(view: uiBackgroundView, level: 1)
            populateLabelsByValueAndLevels(1)
        case "Rare":
            BackgroundFormatter.formatUIBackgroundViewFromLevel(view: uiBackgroundView, level: 2)
            populateLabelsByValueAndLevels(2)
        case "Epic":
            BackgroundFormatter.formatUIBackgroundViewFromLevel(view: uiBackgroundView, level: 3)
            populateLabelsByValueAndLevels(3)
        case "Legendary":
            BackgroundFormatter.formatUIBackgroundViewFromLevel(view: uiBackgroundView, level: 4)
            populateLabelsByValueAndLevels(4)
        default:
            break
        }
    }

    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var uiBackgroundView: UIView!
    @IBOutlet weak var overallLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var spreadLabel: UILabel!
    @IBOutlet weak var recoilLabel: UILabel!

    ///////////////////////////////////////////////////////////

    @IBOutlet weak var dpsTitle: UILabel!
    @IBOutlet weak var envdmgTitle: UILabel!

    ///////////////////////////////////////////////////////////

    @IBOutlet weak var damageHeadTitle: UILabel!
    @IBOutlet weak var fireRateTitle: UILabel!
    @IBOutlet weak var magazineTitle: UILabel!
    @IBOutlet weak var impactTitle: UILabel!
    @IBOutlet weak var reloadTitle: UILabel!
    @IBOutlet weak var baseTitle: UILabel!
    @IBOutlet weak var sprintTitle: UILabel!
    @IBOutlet weak var jumpFallTitle: UILabel!
    @IBOutlet weak var downsightsTitle: UILabel!
    @IBOutlet weak var standingTitle: UILabel!
    @IBOutlet weak var crouchingTitle: UILabel!
    @IBOutlet weak var horizontalRecoilTitle: UILabel!
    @IBOutlet weak var verticalRecoilTitle: UILabel!
    @IBOutlet weak var angleMaxTitle: UILabel!
    @IBOutlet weak var angleMinTitle: UILabel!
    @IBOutlet weak var downsightsRecoilTitle: UILabel!

    ///////////////////////////////////////////////////////////

    @IBOutlet weak var dpsLabel: UILabel!
    @IBOutlet weak var envdmgLabel: UILabel!

    ///////////////////////////////////////////////////////////

    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var fireRateLabel: UILabel!
    @IBOutlet weak var magazineSizeLabel: UILabel!
    @IBOutlet weak var impactLabel: UILabel!
    @IBOutlet weak var reloadLabel: UILabel!

    ///////////////////////////////////////////////////////////

    @IBOutlet weak var baseSpreadLabel: UILabel!
    @IBOutlet weak var sprintSpreadLabel: UILabel!
    @IBOutlet weak var jumpSpreadLabel: UILabel!
    @IBOutlet weak var downsightsSpreadLabel: UILabel!
    @IBOutlet weak var standingSpreadLabel: UILabel!
    @IBOutlet weak var crouchingSpreadLabel: UILabel!

    ///////////////////////////////////////////////////////////

    @IBOutlet weak var horizontalLabel: UILabel!
    @IBOutlet weak var verticalLabel: UILabel!
    @IBOutlet weak var angleMaxLabel: UILabel!
    @IBOutlet weak var angleMinLabel: UILabel!
    @IBOutlet weak var downsightsRecoilLabel: UILabel!

    var index: Int = 0
    var weaponInfo = Weapons()
    var weaponDetails = WeaponsDetails()
    var weaponModel = JsonService.list

    override func viewDidLoad() {
        super.viewDidLoad()
        likeButtonState = false

        prepareVisuals()
        getLikeStorage()
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }

    func prepareSegment() {
        levelOfWeaponSwitch.removeAllSegments()
        let listOfLevels = weaponModel.getLevelsByWeaponId(weaponInfo.id)
        let titles = ["Common", "Atypical", "Rare", "Epic", "Legendary"]
        for listOfLevel in listOfLevels {
            levelOfWeaponSwitch.insertSegment(withTitle: titles[listOfLevel], at: levelOfWeaponSwitch.numberOfSegments, animated: false)
        }
        levelOfWeaponSwitch.selectedSegmentIndex = 0
    }
    
    func getLikeStorage() {
        if likeStorage.bool(forKey: "weapon_like_\(weaponInfo.id)") {
            likeButton.image = #imageLiteral(resourceName: "loveIconFull")
            likeButtonState = true
        }
    }
    
    func prepareVisuals() {
        backgroundGradient()
        
        detailsViewTitle.title = weaponInfo.name
        weaponModel.setImageByWeaponId(weaponInfo.id, imageView: weaponImage)
        
        weaponImage.layer.zPosition = 1
        levelOfWeaponSwitch.layer.zPosition = 0.9
        levelOfWeaponSwitch.layer.cornerRadius = 3.4
        levelOfWeaponSwitch.layer.masksToBounds = true
        
        prepareSegment()
        getGradientValueforBackgroundImage()
        styleLabels()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    func getGradientValueforBackgroundImage() {
        BackgroundFormatter.formatUIBackgroundViewFromLevel(view: uiBackgroundView, level: weaponDetails.detailLevel)
        shadowOptions.setShadow(image: weaponImage)
        switch weaponDetails.detailLevel {
        case 0:
            populateLabelsByValueAndLevels(0)
            break
        case 1:
            populateLabelsByValueAndLevels(1)
            break
        case 2:
            populateLabelsByValueAndLevels(2)
            break
        case 3:
            populateLabelsByValueAndLevels(3)
            break
        case 4:
            populateLabelsByValueAndLevels(4)
            break
        default:
            break
        }
    }

    func populateLabelsByValueAndLevels(_ level: Int) {
        let details = weaponModel.getDetailsByWeaponIdAndLevel(weaponId: weaponInfo.id, weaponLevel: level)
        dpsLabel.text = String(Float(details.damage) * details.fireRate)
        envdmgLabel.text = String(details.environementDamage)

        damageLabel.text = String(details.damage)
        headLabel.text = String(details.damageHead)
        fireRateLabel.text = String(details.fireRate)
        magazineSizeLabel.text = String(details.magazineSize)
        impactLabel.text = String(details.impact)
        reloadLabel.text = String(details.reloadTime)

        baseSpreadLabel.text = String(details.spreadBase)
        sprintSpreadLabel.text = String(details.spreadSprint)
        jumpSpreadLabel.text = String(details.spreadJump)
        standingSpreadLabel.text = String(details.spreadStanding)
        downsightsSpreadLabel.text = String(details.spreadDownsights)
        crouchingSpreadLabel.text = String(details.spreadCrouching)

        horizontalLabel.text = String(details.recoilHorizontal)
        verticalLabel.text = String(details.recoilVertical)
        angleMaxLabel.text = String(details.recoilMaxAngle)
        angleMinLabel.text = String(details.recoilMinAngle)
        downsightsRecoilLabel.text = String(details.recoilDownsights)

    }

    func styleLabels() {
        let labels = [overallLabel, dpsTitle, envdmgTitle, dpsLabel, envdmgLabel, detailsLabel, damageHeadTitle, fireRateTitle, magazineTitle, impactTitle, reloadTitle, damageLabel, headLabel, fireRateLabel, magazineSizeLabel, impactLabel, reloadLabel, spreadLabel, baseTitle, sprintTitle, jumpFallTitle, downsightsTitle, standingTitle, crouchingTitle, baseSpreadLabel, sprintSpreadLabel, jumpSpreadLabel, standingSpreadLabel, downsightsSpreadLabel, crouchingSpreadLabel, recoilLabel, horizontalRecoilTitle, verticalRecoilTitle, angleMaxTitle, angleMinTitle, downsightsRecoilTitle, horizontalLabel, verticalLabel, angleMaxLabel, angleMinLabel, downsightsRecoilLabel]
        for label in labels {
            shadowOptions.setShadow(label: label!)
        }
    }
}
