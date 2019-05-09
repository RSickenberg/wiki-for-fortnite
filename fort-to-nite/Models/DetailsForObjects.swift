//
//  DetailsForObject.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 06.03.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//
//  README: You need to add only one weapon for all of his levels like (AR + Details for Grey level) -> (Details for green level) -> (Details for blue level) /!\ DON'T FORGET THE WEAPONID TO MATCH THE DETAILS WITH THE WEAPON
//
//          Grey : color 0 / detailLevel 0
//          Green : color 1 / detailLevel 1
//          Blue : color 2 / detailLevel 2
//          Purple : color 3 / detailLevel 3
//          Gold :  color 4 / detailLevel 4
//
//  Since 3.4, weapons can have dissociated style, or colors, like: green / blue
//  For new methods, please, take note of this.

import Foundation
import UIKit
import AlamofireImage

class DetailsForObjects {
    // MARK: - Array
    private var weaponsCollection = [Weapons]()
    private var weaponsDetails = [WeaponsDetails]()
    private var weaponsCategory = [Int]()

    private var itemsCollection = [Items]()
    private var itemsDetails = [ItemsDetails]()
    private var itemsCategory = [Int]()
    
    private var storeCollection = [Store]()
    private var jsonVersion: String?

    // MARK: - Weapons

    func addWeaponToDB(_ weapon: Weapons) {
        weaponsCollection.append(weapon)
    }
    
    func addWeaponCategoryToDB(_ category: Int) {
        if !weaponsCategory.contains(category) {
            weaponsCategory.append(category)
        }
    }

    func addWeaponDetailsToDB(_ details: WeaponsDetails) {
        weaponsDetails.append(details)
    }

    func getAllWeapons() -> [Weapons] {
        return weaponsCollection
    }

    func getAllWeaponsDetails() -> [WeaponsDetails] {
        return weaponsDetails
    }

    func getWeaponsByIndex(index: Int) -> Weapons {
        return weaponsCollection[index]
    }
    
    func getWeaponsByWeaponId(weaponId: Int) -> Weapons {
        let key = weaponsCollection.firstIndex(where: { $0.id == weaponId })
        
        return weaponsCollection[key!]
    }

    func countWeapons() -> Int {
        return weaponsCollection.count
    }

    func getDetailsByWeaponId(weaponId: Int) -> WeaponsDetails {
        let key = weaponsDetails.firstIndex(where: { $0.weaponId == weaponId })

        return weaponsDetails[key!]
    }

    func getDetailsByWeaponIdAndLevel(weaponId: Int, weaponLevel: Int) -> WeaponsDetails {
        let key = weaponsDetails.firstIndex(where: { $0.weaponId == weaponId && $0.detailLevel == weaponLevel })

        return weaponsDetails[key!]
    }

    func countNumberOfLevelsByWeaponId(_ weaponId: Int) -> Int {
        var numberOfLevels: Int = 0

        for detail in weaponsDetails {
            if detail.weaponId == weaponId {
                numberOfLevels += 1
            }
        }

        return numberOfLevels
    }

    func getLevelsByWeaponId(_ weaponId: Int) -> [Int] {
        var levels = [Int]()

        for detail in weaponsDetails {
            if detail.weaponId == weaponId {
                levels.append(detail.detailLevel)
            }
        }

        return levels
    }
    
    func setImageByWeaponId(_ weaponId: Int, imageView: UIImageView!){
        let weapon = getWeaponsByWeaponId(weaponId: weaponId)
        let url = (JsonService.shared.imagePath.url?.absoluteString)! + weapon.img
        
        imageView.af_setImage(withURL: URL(string: url)!, placeholderImage: #imageLiteral(resourceName: "wPlaceHolderGray"), imageTransition: .crossDissolve(0.5))
    }

    ////////////////////////////////////////////////////////////////////////////////////////////// ITEMS
    // MARK: - Items

    func addItemToDB(_ items: Items) {
        itemsCollection.append(items)
    }
    
    func addItemCategoryToDB(_ category: Int) {
        if !itemsCategory.contains(category) {
            itemsCategory.append(category)
        }
    }

    func addItemDetailsToDB(_ details: ItemsDetails) {
        itemsDetails.append(details)
    }

    func getAllItems() -> [Items] {
        return itemsCollection
    }

    func getAllItemsDetails() -> [ItemsDetails] {
        return itemsDetails
    }
    
    func getItemsByItemId(itemId: Int) -> Items {
        let key = itemsCollection.firstIndex(where: { $0.id == itemId })
        
        return itemsCollection[key!]
    }

    func getItemByIndex(index: Int) -> Items {
        return itemsCollection[index]
    }

    func countItems() -> Int {
        return itemsCollection.count
    }

    func getDetailsByItemId(itemId: Int) -> ItemsDetails {
        let key = itemsDetails.firstIndex(where: { $0.itemId == itemId })

        return itemsDetails[key!]
    }
    
    func setImageByItemId(_ itemId: Int, imageView: UIImageView!){
        let item = getItemsByItemId(itemId: itemId)
        let url = (JsonService.shared.imagePath.url?.absoluteString)! + item.img
        
        imageView.af_setImage(withURL: URL(string: url)!, placeholderImage: #imageLiteral(resourceName: "iPlaceHolderGray"), imageTransition: .crossDissolve(0.5))
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////// STORE
    // MARK: - Store
    
    func addStoreToDB(_ storeState: Store) {
        storeCollection.append(storeState)
    }
    
    func getAllStoreItems() -> [Store] {
        return storeCollection
    }
    
    func getStoreItemByIndex(_ storeIndex: Int) -> Store {
        return storeCollection[storeIndex]
    }
    
    func getStoreItemByManifestId(_ storeId: Int) -> Store {
        let key = storeCollection.firstIndex(where: { $0.manifestId == storeId })
        
        return storeCollection[key!]
    }
    
    func setImageByStoreElementId(_ storeId: Int, _ imageView: UIImageView) {
        let storeElement = getStoreItemByManifestId(storeId)
        
        if (storeElement.imageUrl != "unknown") {
            imageView.af_setImage(withURL: URL(string: storeElement.imageUrl)!, placeholderImage: UIImage(named: "storeimage"), imageTransition: .crossDissolve(0.5) )
        }
        else {
            imageView.image = UIImage(named: "storeimage")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////// Others
    // MARK: - MISC
    
    func setJsonVersion(_ version: String) {
        jsonVersion = version
    }
    
    func getJsonVersion() -> String {
        return jsonVersion ?? ""
    }
}
