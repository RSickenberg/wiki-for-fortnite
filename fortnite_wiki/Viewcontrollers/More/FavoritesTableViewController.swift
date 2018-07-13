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
    var damageRangeForWeaponId = [Int : String]()
    var dpsRangeForWeaponId = [Int : String]()
    
    lazy var refresh: UIRefreshControl! = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(FavoritesTableViewController.reloadData(_:)), for: UIControlEvents.allEvents)
        
        refreshControl.tintColor = UIColor.flatPurple
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //statusAlert()
        favoritesTable.dataSource = self
        favoritesTable.delegate = self
        favoritesTable.addSubview(self.refresh)
        prepareVisuals()
        getFavorites()
        favoritesTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getFavorites()
        favoritesTable.reloadData()
        
        if matchedWeaponsIds.count + matchedItemsIds.count == 0 {
            noFavorites.showInKeyWindow()
        }
    }
    
    @objc private func reloadData(_ refreshControl: UIRefreshControl) {
        getFavorites()
        favoritesTable.reloadData()
        refreshControl.endRefreshing()
    }

    // MARK: - TableView

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
        FavoriteCellVisuals(cell)
        
        if matchedWeaponsIds.count > 0 {
            if indexPath.section == 0 {
                let weapon = model.getWeaponsByWeaponId(weaponId: matchedWeaponsIds[indexPath.row])
                
                model.setImageByWeaponId(weapon.id, imageView: cell.cellImage)
                cell.entityDetail.text = damageRangeForWeaponId[weapon.id]
                cell.entityDetail2.text = dpsRangeForWeaponId[weapon.id]
                cell.cellEntityName.text = weapon.name
                
                FormatLevels().formatCellGradients(cell: cell, levels: model.getLevelsByWeaponId(weapon.id))
                indexPathToWeaponId.updateValue(weapon.id, forKey: indexPath)
                
                return cell
            }
        }
        if matchedItemsIds.count > 0 {
            if indexPath.section == 1 || indexPath.section == 0 {
                let item = model.getItemsByItemId(itemId: matchedItemsIds[indexPath.row])
                
                model.setImageByItemId(item.id, imageView: cell.cellImage)
                cell.cellEntityName.text = item.name
                cell.entityDetail.text = "nil"
                cell.entityDetail2.text = "nil"
                cell.entityDetail.isHidden = true
                cell.entityDetail2.isHidden = true
                
                FormatLevels().formatCellGradient(cell: cell, level: item.color)
                indexPathToItemId.updateValue(item.id, forKey: indexPath)
                
                return cell
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "favorite_cell", for: indexPath) as! FavoriteCell
        cell.entityDetail.text = nil
        cell.entityDetail2.text = nil
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPathToWeaponId.index(forKey: indexPath) != nil {
                favoriteStorage.removeObject(forKey: "weapon_like_\(String(describing: indexPathToWeaponId[indexPath]!))")
            }
            
            if indexPathToItemId.index(forKey: indexPath) != nil {
                favoriteStorage.removeObject(forKey: "item_like_\(String(describing: indexPathToItemId[indexPath]!))")
            }
            
            getFavorites()
            
            favoritesTable.reloadData()
        }
    }
    
    // MARK: - Visuals
    
    private func prepareVisuals() {
        tableView.separatorColor = UIColor.black
    }
    
    private func FavoriteCellVisuals(_ cell: FavoriteCell) {
        cell.cellEntityName.textColor = UIColor.white
        cell.entityDetail.textColor = UIColor.white
        cell.entityDetail2.textColor = UIColor.white
        
        shadows.setShadow(label: cell.cellEntityName)
        shadows.setShadow(label: cell.entityDetail)
        shadows.setShadow(label: cell.entityDetail2)
    }
    
//    private func statusAlert() {
//        StatusAlert.multiplePresentationsBehavior = .ignoreIfAlreadyPresenting
//        noFavorites.image = #imageLiteral(resourceName: "DislikeFullHighRes")
//        noFavorites.title = "Oh!"
//        noFavorites.message = "It seems you don't have any favorties. Go love your favorites on the ❤️ top right corner."
//        noFavorites.canBePickedOrDismissed = true
//        noFavorites.appearance = .copyCommon()
//        noFavorites.alertShowingDuration = TimeInterval(exactly: 5)!
//    }
    
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
                damageRangeForWeaponId[weaponId] = getRangeOfDamages(weaponId: weaponId)
                dpsRangeForWeaponId[weaponId] = getRangeOfDPSRate(weaponId: weaponId)
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
    
    private func getRangeOfDamages(weaponId: Int) -> String {
        let levels = model.getLevelsByWeaponId(weaponId)
        var range: String = "Damages : "
        
        for level in levels {
            if level == levels.first {
                let minDamage = model.getDetailsByWeaponIdAndLevel(weaponId: weaponId, weaponLevel: level)
                range.append("\(minDamage.damage)-")
            }
            if level == levels.last {
                let maxDamage = model.getDetailsByWeaponIdAndLevel(weaponId: weaponId, weaponLevel: level)
                range.append("\(maxDamage.damage)")
            }
        }
        
        return range
    }
    
    private func getRangeOfDPSRate(weaponId: Int) -> String {
        let levels = model.getLevelsByWeaponId(weaponId)
        var range: String = "DPS : "
        
        for level in levels {
            if level == levels.first {
                let minRange = model.getDetailsByWeaponIdAndLevel(weaponId: weaponId, weaponLevel: level)
                range.append("\(minRange.damage * Int(minRange.fireRate))-")
            }
            if level == levels.last {
                let maxRange = model.getDetailsByWeaponIdAndLevel(weaponId: weaponId, weaponLevel: level)
                range.append("\(maxRange.damage * Int(maxRange.fireRate))")
            }
        }
        
        return range
    }

}
