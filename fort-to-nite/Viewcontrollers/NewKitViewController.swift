//
//  NewKitViewController.swift
//  fort-to-nite
//
//  Created by Romain Sickenberg on 19.07.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import Foundation
import WhatsNewKit

enum completionResult {
    case success(Bool)
}

class NewKitViewController {
    var configuration = WhatsNewViewController.Configuration()
    
    init() {
        configuration.apply(theme: .darkOrange)
        configuration.apply(animation: .fade)
        configuration.titleView.titleFont = UIFont(name: "BurbankBigCondensed-Bold", size: 45)!
        configuration.itemsView.titleFont = UIFont(name: "BurbankBigCondensed-Bold", size: 34)!
        configuration.itemsView.subtitleFont = UIFont(name: "BurbankBigRegular-Light", size: 21)!
        configuration.itemsView.autoTintImage = true
        configuration.completionButton.title = "Discover your app."
        let detailButton = WhatsNewViewController.DetailButton(
            title: "Learn more",
            action: .website(url: "https://rsickenberg.me/pages/fort-to-nite.html"),
            titleFont: UIFont(name: "BurbankBigRegular-Light", size: 19)!,
            titleColor: .orange
        )
        configuration.detailButton = detailButton
    }
    
    static let welcomeNew = WhatsNew(
        title: "FortPedia",
        items: [
            WhatsNew.Item(
                title: "Data (always) up to date !",
                subtitle: "We use a custom made data source.",
                image: #imageLiteral(resourceName: "network")
            ),
            WhatsNew.Item(
                title: "Same design.",
                subtitle: "Don't loose you head, we look like your favorite game !",
                image: #imageLiteral(resourceName: "windowDesign")
            ),
            WhatsNew.Item(
                title: "Build to be fast, and upgradable.",
                subtitle: "Suggest the next feature !",
                image: #imageLiteral(resourceName: "update")
            ),
            WhatsNew.Item(
                title: "Rate it.",
                subtitle: "If you have time, it takes 2 seconds.",
                image: #imageLiteral(resourceName: "appstore")
            ),
        ]
    )
    
    static let whatsNewViewController = WhatsNewViewController(
        whatsNew: welcomeNew,
        configuration: NewKitViewController().configuration
    )
    
    func getConnectionResult(completion: @escaping (completionResult) -> ()) {
        completion(.success(true))
    }
}
