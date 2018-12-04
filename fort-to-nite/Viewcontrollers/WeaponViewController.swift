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

class WeaponCollectionViewFooterCell : UICollectionViewCell {
    @IBOutlet weak var jsonVersion: UILabel!
    
    func configure() {
        let shadowsOptions = ShadowLayers()
        shadowsOptions.setShadow(label: jsonVersion)
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
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
            if (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String == "1.1.0") {
                self.present(NewKitViewController.whatsNew11ViewController, animated: true)
            }

            let twoSecondsFromNow = DispatchTime.now() + 10.0
            DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) { [navigationController] in
                if navigationController?.topViewController is WeaponViewController {
                    if #available(iOS 10.3, *) {
                        SKStoreReviewController.requestReview()
                        UserDefaults.standard.set(true, forKey: (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)
                    }
                }
            }
        }
        
        let gv = GradientView(frame: self.view.bounds)
        self.view.insertSubview(gv, at: 0)
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! WeaponCollectionViewFooterCell
        let jsonVersion = list.getJsonVersion()
        if (jsonVersion != "") {
            footer.configure()
            footer.jsonVersion.text = "Data pulled from: V\(jsonVersion)"
        } else {
            footer.hide()
        }
        return footer
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
