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
import StoreKit

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
    
    static func lastUpdate() -> Bool {
        let lastVersion = "1.0.8"
        let actualVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let isANewVersion = !UserDefaults.standard.bool(forKey: lastVersion)
        
        if (isANewVersion && lastVersion != actualVersion) {
            UserDefaults.standard.set(true, forKey: lastVersion)
        }
        
        return isANewVersion
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
        
        if (weapon.is_removed == 1) {
            self.weaponName.isEnabled = false
            self.cellimageView.isUserInteractionEnabled = false
            self.cellimageView.alpha = 0.5
        } else {
            self.weaponName.isEnabled = true
            self.cellimageView.isUserInteractionEnabled = true
            self.cellimageView.alpha = 1.0
        }
    }
}

class WeaponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Declarations

    let feedback = UIImpactFeedbackGenerator(style: .light)
    let list = JsonService.list
    let levels = FormatLevels()
    let isFirstLaunch = UserDefaults.isFirstLaunch()
    let updateWelcome = UserDefaults.lastUpdate()
    var cellParentId: Int = 0
    var index: Int?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFirstLaunch {
            SwiftSpinner.hide()
            self.present(NewKitViewController.whatsNewViewController, animated: true)
        }
        
        if updateWelcome && !isFirstLaunch {
            let twoSecondsFromNow = DispatchTime.now() + 3.0
            DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) { [navigationController] in
                if navigationController?.topViewController is WeaponViewController {
                    if #available(iOS 10.3, *) {
                        SKStoreReviewController.requestReview()
                        UserDefaults.standard.set(true, forKey: (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)
                    }
                }
            }
        }
        
        backgroundGradient()
        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
        index = 0
    }

    // MARK: - Data
    
    func getData() {
        if (list.countWeapons() == 0 ) { // Used if data is fetched from somewhere else. (3D touch actions)
            SwiftSpinner.setTitleFont(UIFont(name: "BurbankBigCondensed-Bold", size: 25)!)

            SwiftSpinner.show("Loading")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

            JsonImageCoordinator.shared.syncJsonWithImage() { [weak self] result in
                switch result {
                case .success(_):
                    SwiftSpinner.hide()
                    self?.reloadData()
                case .failure(_):
                    SwiftSpinner.show("Tap to retry", animated: false).addTapHandler({
                        self?.getData()
                    }, subtitle: "API is in maintenance, or a new update is available.")
                }
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
