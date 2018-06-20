//
//  ViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework
import PKHUD

class WeaponCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellimageView: UIImageView!
    @IBOutlet weak var cellGradientName: UIView!
    @IBOutlet weak var weaponName: UILabel!
}

class WeaponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let feedback = UIImpactFeedbackGenerator(style: .light)
    let list = JsonService.list
    let shadowsOptions = ShadowLayers()
    let levels = FormatLevels()
    var cellParentId: Int = 0
    var index: Int?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        backgroundGradient()
        collectionView.delegate = self
        collectionView.dataSource = self
        index = 0
    }
    
    func getData() {
        HUD.show(.labeledProgress(title: "Loading", subtitle: nil))
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        JsonImageCoordinator.shared.syncJsonWithImage() { [weak self] result in
            switch result {
            case .success(_):
                HUD.hide(animated: true)
                self?.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            case .failure(_):
                HUD.flash(.labeledError(title: "Oops", subtitle: "Please, reload the application."))
                ErrorManager.showMessage("Network Error", message: "API is in maintenance, or a new update is available.")
            }
        }
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }

    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = BackgroundColors().gl
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
        let listOfLevels = list.getLevelsByWeaponId(weapon.id)

        levels.formatCellGradients(cell: cell, levels: listOfLevels)
        shadowsOptions.setShadow(label: cell.weaponName)
        shadowsOptions.setGradientShadow(cell: cell.cellGradientName)
        
        cell.cellGradientName.layer.zPosition = 10
        cell.weaponName.text = weapon.name
        list.setImageByWeaponId(weapon.id, imageView: cell.cellimageView)

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
            dataToDisplay.weaponModel = list
            dataToDisplay.weaponInfo = list.getWeaponsByIndex(index: self.index!)
            dataToDisplay.weaponDetails = list.getDetailsByWeaponId(weaponId: dataToDisplay.weaponInfo.id)
        default:
            break
        }
    }
}
