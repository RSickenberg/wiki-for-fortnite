//
//  fort_to_niteUITests.swift
//  fort-to-niteUITests
//
//  Created by Romain Sickenberg on 03.08.18.
//  Copyright © 2018 Romain Sickenberg. All rights reserved.
//

import XCTest

class fort_to_niteUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element
        element.tap()
        app.scrollViews.otherElements.containing(.staticText, identifier:"Overall :").element.tap()
        
        let assaultRiffleBurstNavigationBar = app.navigationBars["Assault Riffle (burst)"]
        assaultRiffleBurstNavigationBar.buttons["Item"].tap()
        assaultRiffleBurstNavigationBar.buttons["WEAPONS"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Items"].tap()
        element.tap()
        app.navigationBars["Explosive grenade"].buttons["ITEMS"].tap()
        tabBarsQuery.buttons["More"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Your Favorites."]/*[[".cells.staticTexts[\"Your Favorites.\"]",".staticTexts[\"Your Favorites.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Your favorites"].buttons["Edit"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete Assault Riffle (burst), Damages : 27-30, DPS : 47.25 - 52.5"]/*[[".cells.buttons[\"Delete Assault Riffle (burst), Damages : 27-30, DPS : 47.25 - 52.5\"]",".buttons[\"Delete Assault Riffle (burst), Damages : 27-30, DPS : 47.25 - 52.5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2.buttons["Delete"].tap()
    }
    
}
