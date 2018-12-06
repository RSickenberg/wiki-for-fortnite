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
    var configuration11 = WhatsNewViewController.Configuration()
    
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
            action: .website(url: "https://rsickenberg.me/static/pages/fort-to-nite.html"),
            titleFont: UIFont(name: "BurbankBigRegular-Light", size: 19)!,
            titleColor: .orange
        )
        configuration.detailButton = detailButton
        
        configuration11 = configuration // Welcome 1.1, remove on 1.1.2?
        
        configuration11.completionButton.title = "Discover the 1.1"
        configuration11.detailButton = nil
        configuration11.completionButton.action = .custom(action: { [weak self] WhatsNewViewController in
            
        })
    }
    
    static let welcomeNew = WhatsNew(
        title: "FORT-TO-NITE",
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
    
    static let welcome11 = WhatsNew(
        title: "Version 1.1",
        items: [
            WhatsNew.Item(
                title: "Live Market",
                subtitle: "Have a direct view of the market in the real game!",
                image: nil
            ),
            WhatsNew.Item(
                title: "New Icons",
                subtitle: "Some icons have been redesigned to match the new ones",
                image: nil
            ),
            WhatsNew.Item(
                title: "4.5k Downloads!",
                subtitle: "A huge thanks, Fort-to-nite passed top 25 in reference section!",
                image: nil
            )
        ]
    )
    
    static let whatsNewViewController = WhatsNewViewController(
        whatsNew: welcomeNew,
        configuration: NewKitViewController().configuration
    )
    
    static let whatsNew11ViewController = WhatsNewViewController(
        whatsNew: welcome11,
        configuration: NewKitViewController().configuration11
    )
    
    func getConnectionResult(completion: @escaping (completionResult) -> ()) {
        completion(.success(true))
    }
}
