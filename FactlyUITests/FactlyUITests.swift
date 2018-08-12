//
//  FactlyUITests.swift
//  FactlyUITests
//
//  Created by Joey Tawadrous on 12/08/2018.
//  Copyright © 2018 Joey Tawadrous. All rights reserved.
//

import XCTest

class FactlyUITests: XCTestCase {
        
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
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		
		let app = XCUIApplication()
//		app.alerts["“Factly” Would Like to Send You Notifications"].buttons["Allow"].tap()
		
		let factlyIcon = app/*@START_MENU_TOKEN@*/.scrollViews/*[[".otherElements[\"Home screen icons\"]",".otherElements[\"SBFolderScalingView\"].scrollViews",".scrollViews"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.otherElements.icons["Factly"]
		factlyIcon.tap()
		snapshot("Fact1")
		factlyIcon.tap()
		snapshot("Fact2")
		factlyIcon.tap()
		snapshot("Fact3")
		factlyIcon.tap()
		snapshot("Fact4")
		factlyIcon.tap()
		snapshot("Fact5")
    }
    
}
