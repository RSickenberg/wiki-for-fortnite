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
    
    @IBOutlet weak var collectionView: UICollectionView!
    let feedback = UIImpactFeedbackGenerator(style: .light)
    let colors = BackgroundColors()
    let list = DetailsForObjects()
    var cellParentId: Int = 0
    var index: Int?
    
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
        let level = item.itemColor
        let shadowsOptions = ShadowLayers()

        shadowsOptions.setLayer(cell: cell)
        shadowsOptions.setLayer(label: cell.cellItemLabel)

        cell.cellGradientName.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: cell.cellGradientName.frame, colors: [UIColor.clear, UIColor.clear, UIColor.flatBlack])
        cell.cellImageView.image = UIImage(named: item.itemImg)
        cell.cellItemLabel.text = item.itemName
        
        switch level {
        case 0:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("4A4A4A")!, HexColor("969696")!])
            break
        case 1:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("037E00")!, HexColor("69E41A")!])
            break
        case 2:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("004080")!, HexColor("00BFFF")!])
            break
        case 3:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("530080")!, HexColor("D257FF")!])
            break
        case 4:
            cell.backgroundColor = GradientColor(UIGradientStyle.diagonal, frame: cell.frame, colors: [HexColor("805600")!, HexColor("FFD528")!])
            break
        default:
            cell.backgroundColor = UIColor.black
            break
        }
        
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
