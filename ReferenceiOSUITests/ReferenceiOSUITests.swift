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
    let labelIdentifier = "label"
    let buttonIdentifier = "buttonGenerateCurrency"
    
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
    
    // TODO: Test is Label Available on UI
    /// UI Test to identify the label on Screen
    /// Access the label using its accessibility identifier.
    func testLabelAvailable() {
        // Arrange
        let currencyLabel = app.staticTexts[labelIdentifier]
        let currencyLabelText = currencyLabel.label
        
        debugPrint("Currency Label Text is: \(currencyLabelText)")
        
        // Assert
        XCTAssertTrue(currencyLabel.exists, "Could not find the label to display the currency")
    }
    
    // TODO: Test if label content is properly visible
    /// Check if the width of the label is less than parent view
    /// For the larger text make sure label has multiple lines [number of lines = 0]
    /// and textTruncate property is set to .wrap
    func testLabelIsFullyVisible() {
        // Given
        let label = app.staticTexts[labelIdentifier]
        let button = app.buttons[buttonIdentifier]
        
        // When
        button.tap()
        
        let labelFrame = label.frame
        let parentFrame = app.windows.firstMatch.frame
        
        // Convert the label's frame coordinates to be relative to the parent view
        let relativeLabelFrame = CGRect(x: labelFrame.minX - parentFrame.minX, y: labelFrame.minY - parentFrame.minY, width: labelFrame.width, height: labelFrame.height)
        
        // Assert
        XCTAssertTrue(relativeLabelFrame.width <= parentFrame.width, "Label content width is larger than device view.")
    }
    
    // TODO: Test is Button Available on UI
    /// UI Test to identify the button on Screen
    /// accessibilityIdentifier = 'buttonGenerateCurrency'
    func testButtonAvailable() {
        // Arrange
        let button = app.buttons[buttonIdentifier]
        
        // Assert
        XCTAssertEqual(button.exists, true, "Could not find the button to generate the currency")
    }
    
    // TODO: - Test is Button Clickable on UI
    /// UI Test to check the clicking ability of button
    /// To check if user interaction is not disabled
    /// accessibilityIdentifier = 'buttonGenerateCurrency'
    func testButtonClickable() {
        let button = app.buttons[buttonIdentifier]
        
        XCTAssertTrue(button.isEnabled, "Generate currency button is not enabled.")
        XCTAssertEqual(button.isHittable, true, "Generate currency button is not clickable.")
    }
    
    // TODO: Test Currency Label value is assigned
    /// Check if label is assigned with currency generated on button tap
    /// Compare label value is different than earlier, after clicking the button
    func testLabelValueChanged() {
        // Given
        let currencyLabel = app.staticTexts[labelIdentifier]
        let initialText = currencyLabel.label // Hello
        let button = app.buttons[buttonIdentifier]
        
        // When
        button.tap()
        let updatedText = currencyLabel.label // Currency
        
        // Than
        XCTAssertFalse(initialText == updatedText, "Currency label value not changed on generate button click.")
    }
    
    
    // TODO: Test generated currency components
    /// check if currency string has "Euro" symbol
    /// Check if currency has Fractional decimals followed by ','
    /// Check Fractional Decimal count must be 2
    func testGenerateCurrency() {
        // Given
        let currencyLabel = app.staticTexts[labelIdentifier]
        let button = app.buttons[buttonIdentifier]
        
        // When
        button.tap()
        let currencyLabelText = currencyLabel.label
        
        // Then
        XCTAssertTrue(currencyLabelText.contains("€"), "\'nl_NL\' currency symbol is missing.")
        XCTAssertTrue(currencyLabelText.contains(","), "Fraction Digits are missing as per \'nl_NL\' currency format.")
        let currencyComponents = currencyLabelText.components(separatedBy: ",")
        XCTAssertEqual(currencyComponents[1].count, 2, "Incorrect fraction digits.")
    }
    
}

