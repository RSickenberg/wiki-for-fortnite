//
//  JsonService.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 27.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//
//

import Foundation
import Alamofire

struct jsonStruct: Decodable {
    let weapons: [Weapons]
    let details: [WeaponsDetails]
    let items: [Items]
    let itemDetails: [ItemsDetails]
    let version: String?
}

enum Throwable<T: Decodable>: Decodable {
    case success(T)
    case failure(Error)
    
    init(from decoder: Decoder) throws {
        do {
            let decoded = try T(from: decoder)
            self = .success(decoded)
        } catch let error {
            self = .failure(error)
        }
    }
}

enum ConnectionResult {
    case success(jsonStruct), failure(Error)
}

enum ConnectionStoreResult {
    case success([Store]), failure(Error)
}

enum MessagesResult {
    case success([Messages]), failure(Error)
}

class JsonService {

    // MARK: - Singletons
    
    static let shared = JsonService()
    static let list = DetailsForObjects()

    // MARK: - Declarations
    
    var jsonPath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/prod.json")!)
    //var jsonPath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/staging.json")!)
    var imagePath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/imgs/")!)
    var messagePath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/messages.json")!)
    
    // MARK: Store
    
    var storePath = URLRequest(url: URL(string: "https://api.fortnitetracker.com/v1/store")!)
    
    let storeHeader: HTTPHeaders = [
        "TRN-Api-Key": "fe51eb10-38ee-40e8-a6f5-68187ae72bd3"
    ]
    
    init() {
        if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
            jsonPath.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            imagePath.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            storePath.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        } else {
            jsonPath.cachePolicy = .returnCacheDataElseLoad
            imagePath.cachePolicy = .returnCacheDataElseLoad
            storePath.cachePolicy = .returnCacheDataElseLoad
        }
    }

    // MARK: - Promises
    
    func fetchJsonAlamo(completion: @escaping (ConnectionResult) -> ()) {
        Alamofire.request((jsonPath.url?.absoluteString)!, method: .get).validate().responseJSON() { [weak self] response in
            print("JSON: \(response.data?.count ?? 0) bytes downloaded")
            print("JSON: Request: \(String(describing: response.request))")
            print("JSON: Response: \(String(describing: response.response))")
            print("JSON: Result: \(String(describing: response.result))")
            
            guard self != nil else { return }

            switch response.result {
            case .success(_):
            if let json = response.data {
                do {
                    let jsonObject = try JSONDecoder().decode(jsonStruct.self, from: json)
                    
                    let weapons = jsonObject.weapons.sorted { $0.group < $1.group }

                    for weapon in weapons {
                        JsonService.list.addWeaponToDB(weapon)
                        JsonService.list.addWeaponCategoryToDB(weapon.group)
                    }

                    for weaponDetails in jsonObject.details {
                        JsonService.list.addWeaponDetailsToDB(weaponDetails)
                    }
                    
                    let items = jsonObject.items.sorted { $0.group < $1.group }

                    for item in items {
                        JsonService.list.addItemToDB(item)
                        JsonService.list.addItemCategoryToDB(item.group)
                    }

                    for itemDetails in jsonObject.itemDetails {
                        JsonService.list.addItemDetailsToDB(itemDetails)
                    }
                    
                    JsonService.list.setJsonVersion(jsonObject.version ?? "")
                    
                    if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                        ErrorManager.showMessage("Network debug", message: "Size: \(response.data?.count ?? 0) bytes    Response: \(response.result)")
                    }
                    
                    completion(.success(jsonObject))
                }
                catch let jsonErr {
                    if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                        ErrorManager.showMessage("Json Status", message: jsonErr.localizedDescription)
                        print(jsonErr)
                    }
                    
                    completion(.failure(jsonErr))
                }
            }
            case .failure(let error):
                if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                    ErrorManager.showMessage("Failure Status", message: error.localizedDescription)
                }
                
                completion(.failure(error))
            }
        }
    }
    
    func fetchJsonStoreAlamo(completion: @escaping (ConnectionStoreResult) -> ()) {
        Alamofire.request((storePath.url?.absoluteString)!, method: .get, headers: storeHeader).validate().responseJSON() { [weak self] response in
            print("JSON: \(response.data?.count ?? 0) bytes downloaded")
            print("JSON: Request: \(String(describing: response.request))")
            print("JSON: Response: \(String(describing: response.response))")
            print("JSON: Result: \(String(describing: response.result))")
            
            guard self != nil else { return }
            
            switch response.result {
            case .success(_):
                if let json = response.data {
                    do {
                        let jsonObject = try JSONDecoder().decode([Throwable<Store>].self, from: json)
                        let store = jsonObject.compactMap { $0.value }
                        
                        let storeItems = store.sorted { $0.storeCategory > $1.storeCategory }
                        
                        for storeObject in storeItems {
                            JsonService.list.addStoreToDB(storeObject)
                        }
                        
                        completion(.success(store))
                    }
                    catch let jsonErr {
                        if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                            ErrorManager.showMessage("Json Status", message: jsonErr.localizedDescription)
                            print(jsonErr)
                        }
                        
                        completion(.failure(jsonErr))
                    }
                }
            case .failure(let error):
                if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                    ErrorManager.showMessage("Failure Status", message: error.localizedDescription)
                }
                
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchMessagesAlamo(completion: @escaping (MessagesResult) -> ()) {
        Alamofire.request((messagePath.url?.absoluteString)!, method: .get).validate().responseJSON() { [weak self] response in
            print("JSON: \(response.data?.count ?? 0) bytes downloaded")
            print("JSON: Request: \(String(describing: response.request))")
            print("JSON: Response: \(String(describing: response.response))")
            print("JSON: Result: \(String(describing: response.result))")
            
            guard self != nil else { return }
            
            switch response.result {
            case .success(_):
                if let json = response.data {
                    do {
                        let jsonObject = try JSONDecoder().decode([Throwable<Messages>].self, from: json)
                        let messages = jsonObject.compactMap { $0.value }
                        
                        for message in messages {
                            JsonService.list.setMessages(message: message)
                        }
                        
                        completion(.success(messages))
                    } catch let jsonErr {
                        if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                            ErrorManager.showMessage("Json Status", message: jsonErr.localizedDescription)
                            print(jsonErr)
                        }
                        
                        completion(.failure(jsonErr))
                    }
                }
            case .failure(let error):
                if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
                    ErrorManager.showMessage("Failure Status", message: error.localizedDescription)
                }
                
                completion(.failure(error))
            }
        }
    }
}
