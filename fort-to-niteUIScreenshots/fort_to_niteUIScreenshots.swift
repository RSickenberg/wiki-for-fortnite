//
//  fort_to_niteUIScreenshots.swift
//  fort-to-niteUIScreenshots
//
//  Created by Romain Sickenberg on 03.08.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import XCTest

class fort_to_niteUIScreenshots: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
    func testExample() {
        let app = XCUIApplication()
        snapshot("01WeaponsCollections")
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        app.navigationBars["Assault Rifle (burst)"].buttons["Item"].tap()
        sleep(3)
        
        app.tabBars.buttons["Weapons"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        snapshot("02Weapon1")
        
        let itemButton = app.navigationBars["Assault Rifle (SCAR)"].buttons["Item"]
        itemButton.tap()
        sleep(3)
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Weapons"].tap()
        tabBarsQuery.buttons["Items"].tap()
        snapshot("03ItemsCollections")
        app.collectionViews.children(matching: .cell).element(boundBy: 6).children(matching: .other).element.tap()
        snapshot("04Item1")
        app.navigationBars["Slurp juice"].buttons["Item"].tap()
        sleep(3)
        
        app.tabBars.buttons["Items"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.tap()
        app.navigationBars["Medium shield"].buttons["Item"].tap()
        sleep(3)
        app.tabBars.buttons["More"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Your Favorites."]/*[[".cells.staticTexts[\"Your Favorites.\"]",".staticTexts[\"Your Favorites.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("05Favorites")
    }
    
}
