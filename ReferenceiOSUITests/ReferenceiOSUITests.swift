//
//  ReferenceiOSUITests.swift
//  ReferenceiOSUITests
//
//  Created by Dunya Kirkali on 27/03/2019.
//  Copyright © 2019 ABN AMRO. All rights reserved.
//

import XCTest
@testable import ReferenceiOS

class ReferenceiOSUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app.terminate()
        app = nil
    }
    
    // MARK: - Test Cases for UI
    
    // TODO: - test is Label Available on UI
    func testLabelAvailable() {
        let label = app.staticTexts["label"]
        let textInLabel = app.staticTexts["label"].label
        
        print("*** Label with title \"\(textInLabel)\" exists = \(label.exists)")
        XCTAssertEqual(label.exists, true, "Couldn't find the label to display the currency")
    }
    
    func testButtonAvailable() {
        let button = app.buttons["buttonGenerateCurrency"]
        print("*** exists = \(button.exists)")
        
        XCTAssertEqual(button.exists, true, "Couldn't find the button to generate the currency")
    }
    
    func testButtonClickable() {
        let button = app.buttons["buttonGenerateCurrency"]
        print("*** hittable = \(button.isHittable)")
        
        XCTAssertEqual(button.isHittable, true, "Couldn't click the button to generate the currency")
    }
    
    // >>>>>>>>>>
    
    func testGenerateCurrency() {
        // Given
        let button = app.buttons["buttonGenerateCurrency"]
        let currencyRegex = "^(€\\s)(?!0\\d)\\d{1,3}(?:\\.\\d{3})*,\\d{2}$"
        
        // When
        button.tap()
        
        // Then
        let currencyLabel = app.staticTexts["label"]
        let currencyLabelText = currencyLabel.label
        
        XCTAssertTrue(currencyLabelText.matches(currencyRegex), "Generated currency is not in nl_NL currency format.")
        
    }
    
}

