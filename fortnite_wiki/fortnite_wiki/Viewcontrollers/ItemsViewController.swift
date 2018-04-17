//
//  ItemsViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import ChameleonFramework

class ItemsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellItemLabel: UILabel!
    @IBOutlet weak var cellGradientName: UIView!
    
}

class ItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

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
    }
    
    func backgroundGradient() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.countItems()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemsId", for: indexPath) as! ItemsCollectionCell
        let item = list.getItemByIndex(index: indexPath.row)
        let shadowsOptions = ShadowLayers()

        levels.formatCellGradient(cell: cell, level: item.itemColor)
        shadowsOptions.setShadow(label: cell.cellItemLabel)

        cell.cellGradientName.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: cell.cellGradientName.frame, colors: [UIColor.clear, UIColor.clear, UIColor.flatBlack])
        cell.cellImageView.image = UIImage(named: item.itemImg)
        cell.cellItemLabel.text = item.itemName


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        feedback.impactOccurred()
        performSegue(withIdentifier: "itemDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "itemDetail" :
            let dataToDisplay: DetailsItemViewController = segue.destination as! DetailsItemViewController
            dataToDisplay.index = self.index!
            dataToDisplay.itemInfo = list.getItemByIndex(index: self.index!)
            dataToDisplay.itemDetails = list.getDetailsByItemId(itemId: dataToDisplay.itemInfo.itemId)
            break
        default :
            break
        }
    }
}
