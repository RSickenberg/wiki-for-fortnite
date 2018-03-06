//
//  ViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework

class WeaponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let colors = BackgroundColors()
    let list = DetailsForObjects()
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundGradient()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponId", for: indexPath)
        
        switch list.getDataByIndex(index: indexPath.row).weaponColor {
        case "grey", "green", "blue":
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [UIColor.init(hexString: "969696")!, UIColor.init(hexString: "4FCA00")!, UIColor.init(hexString: "00BFFF")!])
            break
        case "purple", "gold":
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [UIColor.init(hexString: "B83DF2")!, UIColor.init(hexString: "E6BB0E")!])
        default:
            cell.backgroundColor = UIColor.black
            break
        }
        
        // Configure the cell
        
        return cell
    }
    
}
