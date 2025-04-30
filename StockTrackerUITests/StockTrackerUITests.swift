//
//  StockTrackerUITests.swift
//  StockTrackerUITests
//
//  Created by Luis Perez on 4/28/25.
//

import XCTest

final class StockTrackerUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testStockListLoadsAndDisplays() {
        let list = app.tables.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 3))
        
        // Check that at least one row appears
        XCTAssertTrue(list.cells.count > 0, "Stock list should show rows")
    }
    
    func testFavoriteToggleUpdatesFavoritesTab() {
        
        let metaStarButton = app.buttons.matching(identifier: "star-META").firstMatch
        XCTAssertTrue(metaStarButton.waitForExistence(timeout: 3), "META star button should exist")
        
        // Tap to favorite
        metaStarButton.tap()
        
        // Switch to Favorites tab
        app.tabBars.buttons["Favorites"].tap()
        
        // Verify the stock now appears in the favorites list
        let favoriteCell = app.cells.containing(.staticText, identifier: "META").firstMatch
        XCTAssertTrue(favoriteCell.waitForExistence(timeout: 2), "Favorited stock should appear in favorites list")
        
        // Tap again to unfavorite
        let unfavoriteButton = app.buttons.matching(identifier: "star-META").firstMatch
        unfavoriteButton.tap()
        
        // Go back to Stocks tab
        app.tabBars.buttons["Stocks"].tap()
    }

}
