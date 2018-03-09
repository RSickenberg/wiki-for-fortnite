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
    @IBOutlet weak var damageLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var fireRateLabel: UILabel!
    @IBOutlet weak var magazineSizeLabel: UILabel!
    @IBOutlet weak var impactLabel: UILabel!
    @IBOutlet weak var reloadLabel: UILabel!
    
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