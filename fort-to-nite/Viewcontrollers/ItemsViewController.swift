//
//  ItemsViewController.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 05.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit

class ItemsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellItemLabel: UILabel!
    @IBOutlet weak var cellGradientName: UIView!
    
    func configure() {
        let shadowsOptions = ShadowLayers()
        shadowsOptions.setShadow(label: cellItemLabel)
        shadowsOptions.setGradientShadow(cell: cellGradientName)
    }
    
    func modelData(_ item: Items) {
        cellItemLabel.text = item.name
        JsonService.list.setImageByItemId(item.id, imageView: cellImageView)
    }
}

class ItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Declarations

    let feedback = UIImpactFeedbackGenerator(style: .light)
    let list = JsonService.list
    let levels = FormatLevels()

    var cellParentId: Int = 0
    var index: Int?

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        backgroundGradient()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadData()
    }

    // MARK: - Data

    func reloadData() {
        self.collectionView?.reloadData()
    }

    // MARK: - Collection view

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.countItems()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemsId", for: indexPath) as! ItemsCollectionCell
        let item = list.getItemByIndex(index: indexPath.row)
        cell.configure()
        cell.modelData(item)
        levels.formatCellGradient(cell: cell, level: item.color)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        feedback.impactOccurred()
        performSegue(withIdentifier: "itemDetail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "itemDetail":
            let dataToDisplay: DetailsItemViewController = segue.destination as! DetailsItemViewController
            dataToDisplay.index = self.index!
            dataToDisplay.itemInfo = list.getItemByIndex(index: self.index!)
            dataToDisplay.itemDetails = list.getDetailsByItemId(itemId: dataToDisplay.itemInfo.id)
            break
        default:
            break
        }
    }

    private func backgroundGradient() {
        BackgroundColors().backgroundGradient(view: view)
    }
}
