//
//  DetailsViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework

class DetailsViewController: UIViewController {
    
    let colors = BackgroundColors()

    @IBOutlet weak var detailsViewTitle: UINavigationItem!
    @IBOutlet weak var levelOfWeaponSwitch: UISegmentedControl!
    @IBAction func levelOfWeaponSwitch(_ sender: UISegmentedControl) {
        // Change level here
        let feedback = UISelectionFeedbackGenerator()
        feedback.selectionChanged()
        
        print(levelOfWeaponSwitch.titleForSegment(at: levelOfWeaponSwitch.selectedSegmentIndex)!)
        weaponDetails.detailLevel = levelOfWeaponSwitch.selectedSegmentIndex
    }
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var UIBackgroundView: UIView!
    
    var index: Int = 0
    var weaponInfo = Weapons()
    var weaponDetails = WeaponsDetails()
    var weaponModel = DetailsForObjects()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundGradient()
        
        detailsViewTitle.title = weaponInfo.weaponName
        weaponImage.image = UIImage(named: weaponInfo.weaponImg)
        
        getGradientValueforBackgroundImage()
        prepareSegment()
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
            UIBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: UIBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "969696")!, UIColor.clear])
            break
        case 1 :
            UIBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: UIBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "4FCA00")!, UIColor.clear])
            break
        case 2 :
            UIBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: UIBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "00BFFF")!, UIColor.clear])
            break
        case 3 :
            UIBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: UIBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "B83DF2")!, UIColor.clear])
            break
        case 4 :
            UIBackgroundView.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: UIBackgroundView.frame, colors: [UIColor.clear ,UIColor.init(hexString: "E6BB0E")!, UIColor.clear])
            break
        default:
            break
        }
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
