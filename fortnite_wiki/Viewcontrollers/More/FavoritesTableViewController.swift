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
    
    let model = JsonService.list
    let items = JsonService.list.getAllItems()
    let weapons = JsonService.list.getAllWeapons()
    let itemsDetails = JsonService.list.getAllItemsDetails()
    let weaponsDetails = JsonService.list.getAllWeaponsDetails()
    let favoriteStorage = UserDefaults.standard
    
    var favoriteItems: [String] = []
    var favoriteWeapons: [String] = []
    var matchedWeaponsIds: [Int] = []
    var matchedItemsIds: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFavorites()
    }
    
    func getFavorites() {
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite_cell", for: indexPath) as! FavoriteCell

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
