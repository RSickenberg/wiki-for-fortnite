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

    let feedback = UIImpactFeedbackGenerator(style: .light)
    let colors = BackgroundColors()
    let list = DetailsForObjects()
    let levels = FormatLevels()
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

        shadowsOptions.setLayer(label: cell.weaponName)
        shadowsOptions.setLayer(cell: cell)
        cell.cellGradientName.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: cell.cellGradientName.frame, colors: [UIColor.clear, UIColor.clear, UIColor.flatBlack])
        cell.weaponName.text = weapon.weaponName

        levels.formatCellGradients(cell: cell, levels: listOfLevels)

        cell.cellimageView.image = UIImage(named: weapon.weaponImg)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
