//
//  StoreViewController.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 15.11.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import UIKit
import SwiftSpinner
import StoreKit

enum StoreType {
    case daily
    case weekly
    
    var title: String {
        switch self {
        case .daily: return "Daily Store object"
        case .weekly: return "Weekly Store object"
        }
    }
}

enum StoreRarity {
    case uncomon
    case rare
    case epic
    case legendary
    
    var title: String {
        switch self {
            case .uncomon: return "Handmade"
            case .rare: return "Strudy"
            case .epic: return "Quality"
            case .legendary: return "Fine"
        }
    }
}

class StoreCellViewController: UICollectionViewCell {
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var cellGradiantPrice: UIView!
    @IBOutlet weak var storePrice: UILabel!
    @IBOutlet weak var bluryView: UIView!
    @IBOutlet weak var storeItemName: UILabel!
    
    func configure() {
        let shadowsOptions = ShadowLayers()
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        self.layer.cornerRadius = 6.5
        
        // Gradiant
        cellGradiantPrice.backgroundColor = UIColor.flatBlack
        cellGradiantPrice.layer.borderWidth = 2.0
        
        shadowsOptions.setShadow(label: storePrice)
        shadowsOptions.setShadow(label: storeItemName)
        storePrice.font.withSize(43)
        
        blurView.frame = bluryView.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.contentView.addSubview(storeItemName)
        blurView.bringSubviewToFront(storeItemName)
        self.addSubview(blurView)
        
        NSLayoutConstraint(item: storeItemName, attribute: .centerX, relatedBy: .equal, toItem: bluryView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: storeItemName, attribute: .centerY, relatedBy: .equal, toItem: bluryView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    func modelData(store: Store) {
        let levels = FormatLevels()
        JsonService.list.setImageByStoreElementId(store.manifestId, storeImage)
        storePrice.text = String(store.vBucks)
        storeItemName.text = store.name
        
        switch store.rarity {
        case "Handmade":
            levels.formatUIBackgroundViewFromLevel(view: self, level: 1)
        case "Sturdy":
            levels.formatUIBackgroundViewFromLevel(view: self, level: 2)
        case "Quality":
            levels.formatUIBackgroundViewFromLevel(view: self, level: 3)
        case "Fine", "Legendary":
            levels.formatUIBackgroundViewFromLevel(view: self, level: 4)
        default:
            levels.formatUIBackgroundViewFromLevel(view: self, level: -1)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        storeImage.af_cancelImageRequest()
        storePrice.text = nil
        storeItemName.text = nil
    }
}

class StoreViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate {

    let list = JsonService.list
    var events: StoreType!
    var storeRarity: StoreRarity!

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var infoButton: UIButton!
    
    convenience init(events: StoreType) {
        self.init()
        self.events = events
    }
    
    convenience init(rarity: StoreRarity) {
        self.init()
        self.storeRarity = rarity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVisuals()
        getData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func getData() {
        if list.countStoreElements() == 0 {
            SwiftSpinner.setTitleFont(UIFont(name: "BurbankBigCondensed-Bold", size: 25)!)
            SwiftSpinner.show("Getting last data!")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            JsonImageCoordinator.shared.syncJsonStore() { [weak self] result in
                switch result {
                case .success(_):
                    SwiftSpinner.hide()
                    self?.collectionView.reloadData()
                case .failure(_):
                    SwiftSpinner.show("Tap to retry", animated: false).addTapHandler({
                        self?.getData()
                    }, subtitle: "API may be unavailable, please retry in one minute.")
                }
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    // MARK: - Outlets
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.getAllStoreItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "store_object", for: indexPath) as! StoreCellViewController
        let storeElement = list.getStoreItemByIndex(indexPath.row)

        cell.layer.cornerRadius = 6.5
        cell.configure()
        cell.modelData(store: storeElement)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    // MARK: - Visuals
    
    private func setVisuals() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BurbankBigCondensed-bold", size: 21)!]
        view.clipsToBounds = true
        
        // CollectionView thing
        collectionView.isPagingEnabled = false
        
        let gv = GradientView(frame: self.view.bounds)
        self.view.insertSubview(gv, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "disclamer" {
            let popoverViewController = segue.destination
            
            popoverViewController.popoverPresentationController?.delegate = self
            popoverViewController.popoverPresentationController?.sourceView = infoButton as UIView
            popoverViewController.preferredContentSize = CGSize(width: 200, height: 50)
            popoverViewController.popoverPresentationController?.sourceRect = infoButton.frame
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
