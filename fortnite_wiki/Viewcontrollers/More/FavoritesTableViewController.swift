//
//  FavoritesTableViewController.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 22.06.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var cellEntityName: UILabel!
    @IBOutlet weak var entityDetail: UILabel!
    @IBOutlet weak var entityDetail2: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

class FavoritesTableViewController: UITableViewController {

    @IBOutlet var favoritesTable: UITableView!
    @IBAction func editFavoritesTable(_ sender: Any) {
        if favoritesTable.isEditing {
            favoritesTable.setEditing(false, animated: true)
        } else {
            favoritesTable.setEditing(true, animated: true)
        }
    }
    
    // MARK: - INIT
    
    let model = JsonService.list
    let items = JsonService.list.getAllItems()
    let weapons = JsonService.list.getAllWeapons()
    let itemsDetails = JsonService.list.getAllItemsDetails()
    let weaponsDetails = JsonService.list.getAllWeaponsDetails()
    let favoriteStorage = UserDefaults.standard
    let shadows = ShadowLayers()
    
    var matchedWeaponsIds: [Int] = []
    var matchedItemsIds: [Int] = []
    var lastWeaponPrinted:Int?
    var lastItemPrinted:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        getFavorites()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedWeaponsIds.count + matchedItemsIds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favorite_cell", for: indexPath) as! FavoriteCell
    
        if matchedWeaponsIds.count > 0 {
            for weaponId in matchedWeaponsIds {
                let weapon = model.getWeaponsByWeaponId(weaponId: weaponId)
                cell.cellEntityName.text = weapon.name
                model.setImageByWeaponId(weapon.id, imageView: cell.cellImage)
                matchedWeaponsIds.remove(at: matchedWeaponsIds.index(where: { $0 == weapon.id })!)
                FormatLevels().formatCellGradients(cell: cell, levels: model.getLevelsByWeaponId(weapon.id))
                return cell
            }
        }
        
        if matchedItemsIds.count > 0 {
            for itemId in matchedItemsIds {
                let item = model.getItemsByItemId(itemId: itemId)
                cell.cellEntityName.text = item.name
                model.setImageByItemId(item.id, imageView: cell.cellImage)
                matchedItemsIds.remove(at: matchedItemsIds.index(where: { $0 == item.id })!)
                FormatLevels().formatCellGradient(cell: cell, level: item.color)
                return cell
            }
        }
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Handle Data
    
    private func getFavorites() {
        let rangeOfWeaponsId = weapons.count
        let rangeOfItemsId = items.count
        var weaponId = 0
        var itemId = 0
        
        while weaponId <= rangeOfWeaponsId {
            if favoriteStorage.bool(forKey: "weapon_like_\(weaponId)") {
                matchedWeaponsIds.append(weaponId)
            }
            weaponId = weaponId + 1
        }
        
        while itemId <= rangeOfItemsId {
            if favoriteStorage.bool(forKey: "item_like_\(itemId)") {
                matchedItemsIds.append(itemId)
            }
            itemId = itemId + 1
        }
    }

}
