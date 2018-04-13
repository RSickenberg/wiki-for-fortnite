//
//  ViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework

class WeaponCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellimageView: UIImageView!
    @IBOutlet weak var cellGradientName: UIView!
    @IBOutlet weak var weaponName: UILabel!
}

class WeaponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let colors = BackgroundColors()
    let list = DetailsForObjects()
    var cellParentId: Int = 0
    var index: Int?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        index = 0
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.countWeapons()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponId", for: indexPath) as! WeaponCollectionCell
        let weapon = list.getWeaponsByIndex(index: indexPath.row)
        let listOfLevels = list.getLevelsByWeaponId(weapon.weaponId)
        let shadowsOptions = ShadowLayers()
        
        // Set the style of the cell
        cell.layer.cornerRadius = 6.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.cellGradientName.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: cell.cellGradientName.frame, colors: [UIColor.clear, UIColor.clear, UIColor.flatBlack])
        cell.weaponName.text = weapon.weaponName
        
        shadowsOptions.setLayer(label: cell.weaponName)
        
        switch listOfLevels {
        case [0,1,2]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [UIColor.init(hexString: "969696")!, UIColor.init(hexString: "969696")!, UIColor.init(hexString: "4FCA00")!, UIColor.init(hexString: "00BFFF")!])
            break
        case [1,2]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [UIColor.init(hexString: "4FCA00")!, UIColor.init(hexString: "00BFFF")!])
            break
        case [3,4]:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [UIColor.init(hexString: "B83DF2")!, UIColor.init(hexString: "E6BB0E")!])
        default:
            cell.backgroundColor = UIColor.black
            break
        }
        
        
        cell.cellimageView.image = UIImage(named: weapon.weaponImg)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedback = UIImpactFeedbackGenerator(style: .light)
        index = indexPath.row
        
        feedback.impactOccurred()
        performSegue(withIdentifier: "weaponDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "weaponDetail":
            let dataToDisplay: DetailsWeaponViewController = segue.destination as! DetailsWeaponViewController
            
            dataToDisplay.index = self.index!
            dataToDisplay.weaponInfo = list.getWeaponsByIndex(index: self.index!)
            dataToDisplay.weaponDetails = list.getDetailsByWeaponId(weaponId: dataToDisplay.weaponInfo.weaponId)
        default:
            break
        }
    }
    
}
