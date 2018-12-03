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
        case "Fine":
            levels.formatUIBackgroundViewFromLevel(view: self, level: 4)
        default:
            self.backgroundColor = UIColor.clear
        }
    }
    
    override func prepareForReuse() {
        storeImage.af_cancelImageRequest()
        storePrice.text = nil
        storeItemName.text = nil
    }
}

class StoreViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    let list = JsonService.list
    var events: StoreType!
    var storeRarity: StoreRarity!
    var gl: CAGradientLayer!

    @IBOutlet var collectionView: UICollectionView!
    
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
    
    override func viewDidLayoutSubviews() {
        gl.frame = view.bounds
    }

    
    func getData() {
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
                }, subtitle: "API may be unavailable, please retry")
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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

    private func backgroundGradient() {
        let colorTop = UIColor(red: 55.0 / 255.0, green: 194.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 115.0 / 255.0, green: 50.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0).cgColor
        
        gl = CAGradientLayer()
        gl.frame = view.bounds
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        gl.name = "background_gradient"
        
        view.backgroundColor = UIColor.clear
        view.layer.insertSublayer(gl, at: 0)
    }
    
    private func setVisuals() {
        backgroundGradient()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BurbankBigCondensed-bold", size: 21)!]
        view.clipsToBounds = true
        
        // CollectionView thing
        collectionView.isPagingEnabled = false
    }
}
