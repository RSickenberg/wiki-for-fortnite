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
        
        if (item.is_removed == 1) {
            self.cellItemLabel.isEnabled = false
            self.cellImageView.isUserInteractionEnabled = false
            self.cellImageView.alpha = 0.5
        } else {
            self.cellItemLabel.isEnabled = true
            self.cellImageView.isUserInteractionEnabled = true
            self.cellImageView.alpha = 1.0
        }
    }
}

class ItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Declarations

    let feedback = UIImpactFeedbackGenerator(style: .light)
    let list = JsonService.list
    let levels = FormatLevels()

    var cellParentId: Int = 0
    var index: Int?
    var gl: CAGradientLayer!

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
    
    override func viewDidLayoutSubviews() {
        gl.frame = view.bounds
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
}
