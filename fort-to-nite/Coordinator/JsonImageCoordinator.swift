//
//  JsonImageCoordinator.swift
//  fortnite_wiki
//
//  Created by Romain Sickenberg on 18.05.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//
//  This file regulate between Jsonservice.getJsonAlamo and ImageUrl

import Foundation

class JsonImageCoordinator {

    // MARK: - Singletons

    static let shared = JsonImageCoordinator()
    let json = JsonService.shared

    // MARK: Data

    func syncJsonWithImage(completion: @escaping (ConnectionResult) -> ()) {
        json.fetchJsonAlamo() { [weak self] result in
            
            guard self != nil else { return }
            switch result {
            case .success(let jsonData):
                completion(.success(jsonData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
