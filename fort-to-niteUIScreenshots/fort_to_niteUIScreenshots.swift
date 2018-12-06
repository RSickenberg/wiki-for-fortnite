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
        XCUIApplication().buttons["Discover your app."].tap()
        sleep(1)
        snapshot("01Main")
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        snapshot("02WpFv")
        app.navigationBars["Assault Rifle (burst)"].buttons["Item"].tap()
        sleep(2)
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Items"].tap()
        snapshot("03Itm")
        collectionViewsQuery.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.children(matching: .image).element.tap()
        snapshot("03shld")
        app.navigationBars["Medium Shield"].buttons["Item"].tap()
        sleep(2)
        tabBarsQuery.buttons["Favorites"].tap()
        XCUIApplication().tables.containing(.other, identifier:"Weapons").element.tap()
        let weaponsTable = XCUIApplication().tables.containing(.other, identifier:"Weapons").element
        weaponsTable.swipeDown()
        sleep(2)
        snapshot("04Fav")
        tabBarsQuery.buttons["Market"].tap()
        sleep(4)
        snapshot("05Market")

    }
    
}
