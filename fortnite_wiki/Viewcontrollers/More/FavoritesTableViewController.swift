//
//  FavoritesTableViewController.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 22.06.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import UIKit
import StatusAlert

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
    let noFavorites = StatusAlert.instantiate(
        withImage: #imageLiteral(resourceName: "DislikeFullHighRes"),
        title: "Oh!",
        message: "It seems you don't have any favorties. Go love your favorites on the ❤️ top right corner",
        canBePickedOrDismissed: true
    )
    
    var matchedWeaponsIds: [Int] = []
    var matchedItemsIds: [Int] = []
    var indexPathToWeaponId = [IndexPath : Int]()
    var indexPathToItemId = [IndexPath : Int]()
    
    lazy var refresh: UIRefreshControl! = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(FavoritesTableViewController.reloadData(_:)), for: UIControlEvents.allEvents)
        
        refreshControl.tintColor = UIColor.flatPurple
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        favoritesTable.addSubview(self.refresh)
        prepareVisuals()
        getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavorites()
        self.favoritesTable.reloadData()
    }
    
    @objc private func reloadData(_ refreshControl: UIRefreshControl) {
        getFavorites()
        favoritesTable.reloadData()
        refreshControl.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var number = 0
        
        if matchedWeaponsIds.count > 0 {
            number = number + 1
        }
        
        if matchedItemsIds.count > 0 {
            number = number + 1
        }
        
        if number == 0 {
            favoritesTable.separatorStyle = .none
        }
        
        return number
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if matchedItemsIds.count != 0 && matchedWeaponsIds.count != 0 {
            if section == 0 {
                return matchedWeaponsIds.count
            }
            else {
                return matchedItemsIds.count
            }
        }
        
        if matchedItemsIds.count == 0 {
            return matchedWeaponsIds.count
        }
        
        if matchedWeaponsIds.count == 0  {
            return matchedItemsIds.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favorite_cell", for: indexPath) as! FavoriteCell
        
        if matchedWeaponsIds.count > 0 {
            if indexPath.section == 0 {
                let weapon = model.getWeaponsByWeaponId(weaponId: matchedWeaponsIds[indexPath.row])
                cell.cellEntityName.text = weapon.name
                model.setImageByWeaponId(weapon.id, imageView: cell.cellImage)
                FormatLevels().formatCellGradients(cell: cell, levels: model.getLevelsByWeaponId(weapon.id))
                indexPathToWeaponId.updateValue(weapon.id, forKey: indexPath)
                return cell
            }
        }
        if matchedItemsIds.count > 0 {
            if indexPath.section == 1 || indexPath.section == 0 {
                let item = model.getItemsByItemId(itemId: matchedItemsIds[indexPath.row])
                cell.cellEntityName.text = item.name
                model.setImageByItemId(item.id, imageView: cell.cellImage)
                FormatLevels().formatCellGradient(cell: cell, level: item.color)
                indexPathToItemId.updateValue(item.id, forKey: indexPath)
                return cell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if matchedItemsIds.count != 0 && matchedWeaponsIds.count != 0 {
            if section == 0 {
                return "Weapons"
            }
            else {
                return "Items"
            }
        }
        
        if matchedItemsIds.count == 0 {
            return "Weapons"
        }
        
        if matchedWeaponsIds.count == 0  {
            return "Items"
        }

        return nil
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPathToWeaponId.index(forKey: indexPath) != nil {
                favoriteStorage.removeObject(forKey: "weapon_like_\(String(describing: indexPathToWeaponId[indexPath]!))")
            }
            
            if indexPathToItemId.index(forKey: indexPath) != nil {
                favoriteStorage.removeObject(forKey: "item_like_\(String(describing: indexPathToItemId[indexPath]!))")
            }
            
            getFavorites()
            
            if indexPath.section == 0 {
                if matchedWeaponsIds.count == 0 && matchedItemsIds.count == 0 {
                    let indexSet = IndexSet(arrayLiteral: indexPath.section)
                    tableView.deleteSections(indexSet, with: UITableViewRowAnimation.automatic)
                }
                    
                if matchedWeaponsIds.count > 1 || matchedItemsIds.count > 1 {
                    favoritesTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
                
                else {
                    favoritesTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
            }
            
            else {
                if matchedItemsIds.count == 0 {
                    let indexSet = IndexSet(arrayLiteral: indexPath.section)
                    tableView.deleteSections(indexSet, with: UITableViewRowAnimation.automatic)
                }
                else {
                    favoritesTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                }
            }
            
            favoritesTable.reloadData()
        }
    }
    
    // MARK: - Visuals
    
    private func prepareVisuals() {
        tableView.separatorColor = UIColor.black
    }
    
    // MARK: - Handle Data
    
    private func getFavorites() {
        matchedItemsIds = []
        matchedWeaponsIds = []
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
        
        if weaponId + itemId == 0 {
            noFavorites.showInKeyWindow()
        }
    }

}
