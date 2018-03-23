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

class DetailsViewController: UIViewController {
    
    let colors = BackgroundColors()

    @IBOutlet weak var titleNavigation: UINavigationItem!
    @IBOutlet weak var detailsViewTitle: UINavigationItem!
    @IBOutlet weak var levelOfWeaponSwitch: UISegmentedControl!
    @IBAction func levelOfWeaponSwitch(_ sender: UISegmentedControl) {
        // Change level here
        let feedback = UISelectionFeedbackGenerator()
        feedback.selectionChanged()
        
        switch levelOfWeaponSwitch.titleForSegment(at: levelOfWeaponSwitch.selectedSegmentIndex)! {
        case "Common":
            populateLabelsByValueAndLevels(0)
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "969696")!, UIColor.clear])
            break
        case "Atypical":
            populateLabelsByValueAndLevels(1)
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "4FCA00")!, UIColor.clear])
        case "Rare":
            populateLabelsByValueAndLevels(2)
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "00BFFF")!, UIColor.clear])
        case "Epic":
            populateLabelsByValueAndLevels(3)
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "B83DF2")!, UIColor.clear])
        case "Legendary":
            populateLabelsByValueAndLevels(4)
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "E6BB0E")!, UIColor.clear])
        default:
            break
        }
    }
    
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var uiBackgroundView: UIView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var spreadLabel: UILabel!
    
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
    
    var index: Int = 0
    var weaponInfo = Weapons()
    var weaponDetails = WeaponsDetails()
    var weaponModel = DetailsForObjects()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundGradient()
        detailsViewTitle.title = weaponInfo.weaponName
        weaponImage.image = UIImage(named: weaponInfo.weaponImg)
        weaponImage.layer.zPosition = 1
        levelOfWeaponSwitch.layer.zPosition = 0.9
        
        prepareSegment()
        getGradientValueforBackgroundImage()
        styleLabels()
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func prepareSegment() {
        levelOfWeaponSwitch.removeAllSegments()
        let listOfLevels = weaponModel.getLevelsByWeaponId(weaponInfo.weaponId)
        let titles = ["Common", "Atypical", "Rare", "Epic", "Legendary"]
        
        for listOfLevel in listOfLevels {
            levelOfWeaponSwitch.insertSegment(withTitle: titles[listOfLevel], at: levelOfWeaponSwitch.numberOfSegments, animated: false)
        }
        
        levelOfWeaponSwitch.selectedSegmentIndex = 0
    }
    
    func getGradientValueforBackgroundImage() {
        
        switch weaponDetails.detailLevel {
        case 0 :
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "969696")!, UIColor.clear])
            populateLabelsByValueAndLevels(0)
            break
        case 1 :
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "4FCA00")!, UIColor.clear])
            populateLabelsByValueAndLevels(1)
            break
        case 2 :
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "00BFFF")!, UIColor.clear])
            populateLabelsByValueAndLevels(2)
            break
        case 3 :
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "B83DF2")!, UIColor.clear])
            populateLabelsByValueAndLevels(3)
            break
        case 4 :
            uiBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: uiBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "E6BB0E")!, UIColor.clear])
            populateLabelsByValueAndLevels(4)
            break
        default:
            break
        }
    }
    
    func populateLabelsByValueAndLevels(_ level: Int) {
        //let listOfLevels = weaponModel.getLevelsByWeaponId(weaponInfo.weaponId)
        
        let details = weaponModel.getDetailsByWeaponIdAndLevel(weaponId: weaponInfo.weaponId, weaponLevel: level)
        
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
        
    }
    
    func styleLabels() {
        let shadowColor = UIColor.black.cgColor
        let shadowRadius: CGFloat = 2.0
        let shadowOpactity: Float = 0.8
        let shadowOffset = CGSize(width: 0, height: 0)
        
        detailsLabel.layer.shadowColor = shadowColor
        detailsLabel.layer.shadowRadius = shadowRadius
        detailsLabel.layer.shadowOpacity = shadowOpactity
        detailsLabel.layer.shadowOffset = shadowOffset
        detailsLabel.layer.masksToBounds = false
        
        damageHeadTitle.layer.shadowColor = shadowColor
        damageHeadTitle.layer.shadowRadius = shadowRadius
        damageHeadTitle.layer.shadowOpacity = shadowOpactity
        damageHeadTitle.layer.shadowOffset = shadowOffset
        damageHeadTitle.layer.masksToBounds = false
        
        fireRateTitle.layer.shadowColor = shadowColor
        fireRateTitle.layer.shadowRadius = shadowRadius
        fireRateTitle.layer.shadowOpacity = shadowOpactity
        fireRateTitle.layer.shadowOffset = shadowOffset
        fireRateTitle.layer.masksToBounds = false
        
        magazineTitle.layer.shadowColor = shadowColor
        magazineTitle.layer.shadowRadius = shadowRadius
        magazineTitle.layer.shadowOpacity = shadowOpactity
        magazineTitle.layer.shadowOffset = shadowOffset
        magazineTitle.layer.masksToBounds = false
        
        impactTitle.layer.shadowColor = shadowColor
        impactTitle.layer.shadowRadius = shadowRadius
        impactTitle.layer.shadowOpacity = shadowOpactity
        impactTitle.layer.shadowOffset = shadowOffset
        impactTitle.layer.masksToBounds = false
        
        reloadTitle.layer.shadowColor = shadowColor
        reloadTitle.layer.shadowRadius = shadowRadius
        reloadTitle.layer.shadowOpacity = shadowOpactity
        reloadTitle.layer.shadowOffset = shadowOffset
        reloadTitle.layer.masksToBounds = false
        
        damageLabel.layer.shadowColor = shadowColor
        damageLabel.layer.shadowRadius = shadowRadius
        damageLabel.layer.shadowOpacity = shadowOpactity
        damageLabel.layer.shadowOffset = shadowOffset
        damageLabel.layer.masksToBounds = false
        
        headLabel.layer.shadowColor = shadowColor
        headLabel.layer.shadowRadius = shadowRadius
        headLabel.layer.shadowOpacity = shadowOpactity
        headLabel.layer.shadowOffset = shadowOffset
        headLabel.layer.masksToBounds = false
        
        fireRateLabel.layer.shadowColor = shadowColor
        fireRateLabel.layer.shadowRadius = shadowRadius
        fireRateLabel.layer.shadowOpacity = shadowOpactity
        fireRateLabel.layer.shadowOffset = shadowOffset
        fireRateLabel.layer.masksToBounds = false
        
        magazineSizeLabel.layer.shadowColor = shadowColor
        magazineSizeLabel.layer.shadowRadius = shadowRadius
        magazineSizeLabel.layer.shadowOpacity = shadowOpactity
        magazineSizeLabel.layer.shadowOffset = shadowOffset
        magazineSizeLabel.layer.masksToBounds = false
        
        impactLabel.layer.shadowColor = shadowColor
        impactLabel.layer.shadowRadius = shadowRadius
        impactLabel.layer.shadowOpacity = shadowOpactity
        impactLabel.layer.shadowOffset = shadowOffset
        impactLabel.layer.masksToBounds = false
        
        reloadLabel.layer.shadowColor = shadowColor
        reloadLabel.layer.shadowRadius = shadowRadius
        reloadLabel.layer.shadowOpacity = shadowOpactity
        reloadLabel.layer.shadowOffset = shadowOffset
        reloadLabel.layer.masksToBounds = false
        
        spreadLabel.layer.shadowColor = shadowColor
        spreadLabel.layer.shadowRadius = shadowRadius
        spreadLabel.layer.shadowOpacity = shadowOpactity
        spreadLabel.layer.shadowOffset = shadowOffset
        spreadLabel.layer.masksToBounds = false
        
        baseTitle.layer.shadowColor = shadowColor
        baseTitle.layer.shadowRadius = shadowRadius
        baseTitle.layer.shadowOpacity = shadowOpactity
        baseTitle.layer.shadowOffset = shadowOffset
        baseTitle.layer.masksToBounds = false
        
        sprintTitle.layer.shadowColor = shadowColor
        sprintTitle.layer.shadowRadius = shadowRadius
        sprintTitle.layer.shadowOpacity = shadowOpactity
        sprintTitle.layer.shadowOffset = shadowOffset
        sprintTitle.layer.masksToBounds = false
        
        jumpFallTitle.layer.shadowColor = shadowColor
        jumpFallTitle.layer.shadowRadius = shadowRadius
        jumpFallTitle.layer.shadowOpacity = shadowOpactity
        jumpFallTitle.layer.shadowOffset = shadowOffset
        jumpFallTitle.layer.masksToBounds = false
        
        downsightsTitle.layer.shadowColor = shadowColor
        downsightsTitle.layer.shadowRadius = shadowRadius
        downsightsTitle.layer.shadowOpacity = shadowOpactity
        downsightsTitle.layer.shadowOffset = shadowOffset
        downsightsTitle.layer.masksToBounds = false
        
        standingTitle.layer.shadowColor = shadowColor
        standingTitle.layer.shadowRadius = shadowRadius
        standingTitle.layer.shadowOpacity = shadowOpactity
        standingTitle.layer.shadowOffset = shadowOffset
        standingTitle.layer.masksToBounds = false
        
        crouchingTitle.layer.shadowColor = shadowColor
        crouchingTitle.layer.shadowRadius = shadowRadius
        crouchingTitle.layer.shadowOpacity = shadowOpactity
        crouchingTitle.layer.shadowOffset = shadowOffset
        crouchingTitle.layer.masksToBounds = false
        
        baseSpreadLabel.layer.shadowColor = shadowColor
        baseSpreadLabel.layer.shadowRadius = shadowRadius
        baseSpreadLabel.layer.shadowOpacity = shadowOpactity
        baseSpreadLabel.layer.shadowOffset = shadowOffset
        baseSpreadLabel.layer.masksToBounds = false
        
        sprintSpreadLabel.layer.shadowColor = shadowColor
        sprintSpreadLabel.layer.shadowRadius = shadowRadius
        sprintSpreadLabel.layer.shadowOpacity = shadowOpactity
        sprintSpreadLabel.layer.shadowOffset = shadowOffset
        sprintSpreadLabel.layer.masksToBounds = false
        
        jumpSpreadLabel.layer.shadowColor = shadowColor
        jumpSpreadLabel.layer.shadowRadius = shadowRadius
        jumpSpreadLabel.layer.shadowOpacity = shadowOpactity
        jumpSpreadLabel.layer.shadowOffset = shadowOffset
        jumpSpreadLabel.layer.masksToBounds = false
        
        standingSpreadLabel.layer.shadowColor = shadowColor
        standingSpreadLabel.layer.shadowRadius = shadowRadius
        standingSpreadLabel.layer.shadowOpacity = shadowOpactity
        standingSpreadLabel.layer.shadowOffset = shadowOffset
        standingSpreadLabel.layer.masksToBounds = false
        
        downsightsSpreadLabel.layer.shadowColor = shadowColor
        downsightsSpreadLabel.layer.shadowRadius = shadowRadius
        downsightsSpreadLabel.layer.shadowOpacity = shadowOpactity
        downsightsSpreadLabel.layer.shadowOffset = shadowOffset
        downsightsSpreadLabel.layer.masksToBounds = false
        
        crouchingSpreadLabel.layer.shadowColor = shadowColor
        crouchingSpreadLabel.layer.shadowRadius = shadowRadius
        crouchingSpreadLabel.layer.shadowOpacity = shadowOpactity
        crouchingSpreadLabel.layer.shadowOffset = shadowOffset
        crouchingSpreadLabel.layer.masksToBounds = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
