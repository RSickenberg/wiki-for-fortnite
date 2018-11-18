//
//  StoreViewController.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 15.11.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import UIKit

enum StoreType {
    case daily
    case weekly
    
    var title: String {
        switch self {
        case .daily: return "Daily Store object"
        case .weekly: return "Weekly Store object"
        }
    }
    
    func controller() -> StoreViewController {
        return StoreViewController(events: self)
    }
}

class StoreCellViewController: UICollectionViewCell {
    @IBOutlet var testLabel: UILabel!
    
}

class StoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let list = JsonService.list
    var events: StoreType!

    @IBOutlet var collectionView: UICollectionView!
    
    convenience init(events: StoreType) {
        self.init()
        self.events = events
    }
    
    override func viewDidLoad() {
        setVisuals()
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        cell.testLabel.text = "Test"
        cell.backgroundColor = UIColor.gray
        
        return cell
    }
    
    // MARK: - Visuals
    
    private func backgroundGradient() {
        BackgroundColors().backgroundGradient(view: view)
    }
    
    private func setVisuals() {
        backgroundGradient()
        title = "MARKET"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "BurbankBigCondensed-bold", size: 21)!]
        view.clipsToBounds = true
        
        // CollectionView thing
    
    }
}
