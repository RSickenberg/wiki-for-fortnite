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
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        snapshot("01WeaponCollectionView")
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        
        let assaultRifleBurstNavigationBar = app.navigationBars["Assault Rifle (burst)"]
        assaultRifleBurstNavigationBar.buttons["Item"].tap()
        sleep(3)
        assaultRifleBurstNavigationBar.buttons["WEAPONS"].tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.tap()
        
        let assaultRifleScarNavigationBar = app.navigationBars["Assault Rifle (SCAR)"]
        snapshot("02AssaultRiffle")
        assaultRifleScarNavigationBar.buttons["Item"].tap()
        sleep(3)
        assaultRifleScarNavigationBar.buttons["WEAPONS"].tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        
        let assaultRifleScopedNavigationBar = app.navigationBars["Assault Rifle (Scoped)"]
        assaultRifleScopedNavigationBar.buttons["Item"].tap()
        sleep(3)
        assaultRifleScopedNavigationBar.buttons["WEAPONS"].tap()
        
        let tabBarsQuery = app.tabBars
        let itemsButton = tabBarsQuery.buttons["Items"]
        itemsButton.tap()
        snapshot("03ItemCollectionView")
        collectionViewsQuery.children(matching: .cell).element(boundBy: 6).children(matching: .other).element.tap()
        app.navigationBars["Slurp juice"].buttons["Item"].tap()
        snapshot("04SlurpJuice")
        itemsButton.tap()
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 7).children(matching: .other).element.tap()
        
        let chugJuiceNavigationBar = app.navigationBars["Chug juice"]
        chugJuiceNavigationBar.buttons["Item"].tap()
        sleep(3)
        chugJuiceNavigationBar.buttons["ITEMS"].tap()
        tabBarsQuery.buttons["More"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Your Favorites."]/*[[".cells.staticTexts[\"Your Favorites.\"]",".staticTexts[\"Your Favorites.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("05FavoritesTable")
    }
    
}
