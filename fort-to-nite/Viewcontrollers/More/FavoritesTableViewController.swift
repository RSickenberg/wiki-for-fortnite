//
//  FavoritesTableViewController.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 22.06.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
// /! Present data like weaponCollection, never display on a view TO REWORK
//

import UIKit
import StatusAlert

// MARK:  Table cells

class WeaponCell: UITableViewCell {
    
    @IBOutlet weak var SuperView: UIView!
    @IBOutlet weak var cellEntityName: UILabel!
    @IBOutlet weak var entityDetail: UILabel!
    @IBOutlet weak var entityDetail2: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    var weaponId: Int!
    
    func configure() {
        cellEntityName.textColor = UIColor.white
        entityDetail.textColor = UIColor.white
        entityDetail2.textColor = UIColor.white
        
        UITableViewCell.shadows.setShadow(label: cellEntityName)
        UITableViewCell.shadows.setShadow(label: entityDetail)
        UITableViewCell.shadows.setShadow(label: entityDetail2)
        
        if UIScreen.main.nativeBounds.height == 1136 { // Set a special constraint for small screens
            NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: SuperView, attribute: NSLayoutConstraint.Attribute.trailingMargin, multiplier: 1, constant: 0).isActive = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImage.af_cancelImageRequest()
        cellImage.image = nil
        cellEntityName.text = nil
        entityDetail.text = nil
        entityDetail2.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func modelWeapon(_ weapon: Weapons, dmgRange: String?, dpsRange: String?) {
        frame = UIScreen.main.bounds.standardized
        UITableViewCell.backgroundHelper.formatCellGradients(cell: self, levels: JsonService.list.getLevelsByWeaponId(weapon.id))
        JsonService.list.setImageByWeaponId(weapon.id, imageView: cellImage)
        cellEntityName.text = weapon.name
        entityDetail.text = dmgRange
        entityDetail2.text = dpsRange
        weaponId = weapon.id
        tag = 0
    }
}

private extension UITableViewCell {
    static let backgroundHelper = FormatLevels()
    static let shadows = ShadowLayers()
}

// MARK: -

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var cellEntityName: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellSuperView: UIView!
    var itemId: Int!
    
    func configure() {
        cellEntityName.textColor = UIColor.white
        UITableViewCell.shadows.setShadow(label: cellEntityName)
        
        if UIScreen.main.nativeBounds.height == 1136 { // Set a special constraint for small screens
            NSLayoutConstraint(item: cellImage, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: cellImage, attribute: NSLayoutConstraint.Attribute.trailingMargin, multiplier: 1, constant: 0).isActive = true
        }
    }
    
    override func prepareForReuse() {
        cellImage.af_cancelImageRequest()
        cellImage.image = nil
        cellEntityName.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func modelItem(_ item: Items) {
        frame = UIScreen.main.bounds.standardized
        JsonService.list.setImageByItemId(item.id, imageView: cellImage)
        cellEntityName.text = item.name
        UITableViewCell.backgroundHelper.formatCellGradient(cell: self, level: item.color)
        itemId = item.id
        tag = 1
    }
}

class FavoritesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoritesTable: UITableView!
    @IBAction func editFavoritesTable(_ sender: Any) {
        if favoritesTable.isEditing {
            favoritesTable.setEditing(false, animated: true)
        } else {
            favoritesTable.setEditing(true, animated: true)
        }
    }
    
    // MARK: - INIT
    
    let model = JsonService.list
    let favoriteStorage = UserDefaults.standard
    
    var matchedWeaponsIds: [Int] = []
    var matchedItemsIds: [Int] = []

    var damageRangeForWeaponId = [Int : String]()
    var dpsRangeForWeaponId = [Int : String]()
    
    lazy var refresh: UIRefreshControl! = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FavoritesTableViewController.reloadData(_:)), for: UIControl.Event.allEvents)
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
        reloadTable()
        
        if matchedWeaponsIds.count + matchedItemsIds.count == 0 {
            let noFavorites = StatusAlert()
            statusAlert(statusAlertInstance: noFavorites)
            noFavorites.showInKeyWindow()
        }
    }

    @objc private func reloadData(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        getFavorites()
        reloadTable()
        refreshControl.endRefreshing()
    }

    func reloadTable() {
        favoritesTable?.reloadData()
    }

    // MARK: - TableView

    func numberOfSections(in tableView: UITableView) -> Int {
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weaponCell = favoritesTable.dequeueReusableCell(withIdentifier: "weapon_cell", for: indexPath) as! WeaponCell
        let itemCell = favoritesTable.dequeueReusableCell(withIdentifier: "item_cell", for: indexPath) as! ItemCell
        if indexPath.section == 0 {
            if matchedWeaponsIds.count > 0 {
                let weapon = model.getWeaponsByWeaponId(weaponId: matchedWeaponsIds[indexPath.row])
                weaponCell.modelWeapon(weapon, dmgRange: damageRangeForWeaponId[weapon.id], dpsRange: dpsRangeForWeaponId[weapon.id])
                
                return weaponCell
            }
        }
        if indexPath.section == 1 || indexPath.section == 0 {
            if matchedItemsIds.count > 0 {
                let item = model.getItemsByItemId(itemId: matchedItemsIds[indexPath.row])
                itemCell.modelItem(item)
                
                return itemCell
            }
        }
        
        return weaponCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let weaponCell = favoritesTable.cellForRow(at: indexPath) as? WeaponCell
        let itemCell = favoritesTable.cellForRow(at: indexPath) as? ItemCell
        
        if editingStyle == .delete {
            if weaponCell?.tag == 0 {
                favoriteStorage.removeObject(forKey: "weapon_like_\(String(describing: weaponCell!.weaponId!))")
                getFavorites()
                if matchedWeaponsIds.count == 0 {
                    let indexSet = IndexSet(arrayLiteral: indexPath.section)
                    self.favoritesTable.deleteSections(indexSet, with: .automatic)
                } else {
                    self.favoritesTable.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            
            if itemCell?.tag == 1 {
                favoriteStorage.removeObject(forKey: "item_like_\(String(describing: itemCell!.itemId!))")
                getFavorites()
                if matchedItemsIds.count == 0 {
                    let indexSet = IndexSet(arrayLiteral: indexPath.section)
                    self.favoritesTable.deleteSections(indexSet, with: .automatic)
                } else {
                    self.favoritesTable.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    // MARK: - Visuals
    
    private func prepareVisuals() {
        favoritesTable.separatorColor = UIColor.black
    }
    
    private func statusAlert(statusAlertInstance: StatusAlert) {
        StatusAlert.multiplePresentationsBehavior = .ignoreIfAlreadyPresenting
        statusAlertInstance.appearance.titleFont = UIFont(name: "BurbankBigCondensed-bold", size: 23)!
        statusAlertInstance.appearance.messageFont = UIFont(name: "BurbankBigCondensed-bold", size: 16)!
        statusAlertInstance.image = #imageLiteral(resourceName: "DislikeFullHighRes")
        statusAlertInstance.title = "Oh!"
        statusAlertInstance.message = "It seems you don't have any favorties. Go love your favorites on the ❤️ top right corner."
        statusAlertInstance.canBePickedOrDismissed = true
        statusAlertInstance.alertShowingDuration = TimeInterval(exactly: 4)!
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont(name: "BurbankBigCondensed-Bold", size: 17)!
        header.textLabel?.textAlignment = .natural
    }

    // MARK: - Handle Data
    
    func getFavorites() {
        matchedItemsIds = []
        matchedWeaponsIds = []
        let rangeOfWeaponsId = model.getAllWeapons().count
        let rangeOfItemsId = model.getAllItems().count
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
                range.append("\(Float(minRange.damage) * round((minRange.fireRate) * 10) / 10) - ")
            }
            if level == levels.last {
                let maxRange = model.getDetailsByWeaponIdAndLevel(weaponId: weaponId, weaponLevel: level)
                range.append("\(Float(maxRange.damage) * round((maxRange.fireRate) * 10) / 10)")
            }
        }
        
        return range
    }

}
