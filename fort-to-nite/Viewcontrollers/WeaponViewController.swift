//
//  ViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftSpinner

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag$
    // https://stackoverflow.com/questions/27208103/detect-first-launch-of-ios-app
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}

class WeaponCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellimageView: UIImageView!
    @IBOutlet weak var cellGradientName: UIView!
    @IBOutlet weak var weaponName: UILabel!
    
    func configure() {
        let shadowsOptions = ShadowLayers()
        shadowsOptions.setShadow(label: weaponName)
        shadowsOptions.setGradientShadow(cell: cellGradientName)
        cellGradientName.layer.zPosition = 10
    }
    
    func modelData(_ weapon: Weapons) {
        weaponName.text = weapon.name
        JsonService.list.setImageByWeaponId(weapon.id, imageView: cellimageView)
    }
}

class WeaponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Declarations

    let feedback = UIImpactFeedbackGenerator(style: .light)
    let list = JsonService.list
    let levels = FormatLevels()
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    var cellParentId: Int = 0
    var index: Int?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFirstLaunch {
            SwiftSpinner.hide()
            self.present(NewKitViewController.whatsNewViewController, animated: true)
        }
        
        backgroundGradient()
        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
        index = 0
    }

    // MARK: - Data
    
    func getData() {
        if (list.countWeapons() == 0 ) {
            SwiftSpinner.setTitleFont(UIFont(name: "BurbankBigCondensed-Bold", size: 25)!)

            SwiftSpinner.show("Loading")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

            JsonImageCoordinator.shared.syncJsonWithImage() { [weak self] result in
                switch result {
                case .success(_):
                    SwiftSpinner.hide()
                    self?.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                case .failure(_):
                    SwiftSpinner.show("Tap to retry", animated: false).addTapHandler({
                        self?.getData()
                    }, subtitle: "API is in maintenance, or a new update is available.")
                }
            }
        }
    }
    
    func reloadData() {
        collectionView?.reloadData()
    }

    // MARK: - Collection View

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
        cell.configure()
        cell.modelData(weapon)

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

    // MARK: - Visuals

    private func backgroundGradient() {
        BackgroundColors().backgroundGradient(view: view)
    }
}
