//
//  StyleGuideViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework

class StyleGuideViewController: UIViewController {
    
    let colors = BackgroundColors()
    
    @IBOutlet var demoWeaponImageView: UIImageView?
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "more_styleGuide", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundGradient()
        backgroundDemoWeapon()
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func backgroundDemoWeapon() {
        demoWeaponImageView?.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: (demoWeaponImageView?.frame)!, colors: [UIColor.init(hexString: "B83DF2")!, UIColor.init(hexString: "E6BB0E")!])
        
        demoWeaponImageView?.layer.cornerRadius = 4.0
        demoWeaponImageView?.layer.shadowOffset = CGSize.zero
        demoWeaponImageView?.layer.shadowRadius = 7.0
        demoWeaponImageView?.layer.shadowOpacity = 0.5
        demoWeaponImageView?.layer.shadowColor = UIColor.flatBlack.cgColor
    }
}
