//
//  JsonService.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 27.04.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//
//  /!\ DONT FORGET TO REMOVE STAGING BEFORE PROD!
//

import Foundation
import Alamofire
import AlamofireImage

struct jsonStruct: Decodable {
    let weapons: [Weapons]
    let details: [WeaponsDetails]
    let items: [Items]
    let itemDetails: [ItemsDetails]
}

enum ConnectionResult {
    case success(jsonStruct), failure(Error)
}

class JsonService {

    // MARK: - Singletons
    
    static let shared = JsonService()
    static let list = DetailsForObjects()

    // MARK: - Declarations
    
    var jsonPath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/prod.json")!)
    //var jsonPath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/staging.json")!)
    var imagePath = URLRequest(url: URL(string: "https://rsickenberg.me/secret/json/fortnite/imgs/")!)
    var json = [String: Any]()
    
    init() {
        if Bundle.main.infoDictionary?["devBuild"] as? Bool == true {
            jsonPath.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            imagePath.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
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

                    for weapon in jsonObject.weapons {
                        JsonService.list.addWeaponToDB(weapon)
                    }

                    for weaponDetails in jsonObject.details {
                        JsonService.list.addWeaponDetailsToDB(weaponDetails)
                    }

                    for item in jsonObject.items {
                        JsonService.list.addItemToDB(item)
                    }

                    for itemDetails in jsonObject.itemDetails {
                        JsonService.list.addItemDetailsToDB(itemDetails)
                    }
                    
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
}
