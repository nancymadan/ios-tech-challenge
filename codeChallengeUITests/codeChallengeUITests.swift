//
//  codeChallengeUITests.swift
//  codeChallengeUITests
//
//  Created by Nancy on 18/05/22.
//  Copyright © 2022 Fernando Suárez. All rights reserved.
//

import XCTest

class codeChallengeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    
    func testDateSwitch() throws {
                                
        let switchButton = app.switches["switchDate"]
        let labelLatestDate = app.staticTexts["Sort by latest Date"]
        let labelOldestDate = app.staticTexts["Sort by oldest Date"]
        
        let isOn = switchButton.value as! String
        
        if isOn == "1" {
            XCTAssertTrue(labelLatestDate.exists)
            XCTAssertFalse(labelOldestDate.exists)
            
            switchButton.tap()
            XCTAssertTrue(labelOldestDate.exists)
            XCTAssertFalse(labelLatestDate.exists)
        } else {
            XCTAssertTrue(labelOldestDate.exists)
            XCTAssertFalse(labelLatestDate.exists)
            
            switchButton.tap()
            XCTAssertTrue(labelLatestDate.exists)
            XCTAssertFalse(labelOldestDate.exists)
        }
    }
}
