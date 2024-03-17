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
        XCTAssertTrue(currencyLabel.exists, Constants.TestFailMessages.labelMissing)
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
        XCTAssertTrue(relativeLabelFrame.width <= parentFrame.width, Constants.TestFailMessages.labelWidthOverflow)
    }
    
    // TODO: Test is Button Available on UI
    /// UI Test to identify the button on Screen
    /// accessibilityIdentifier = 'buttonGenerateCurrency'
    func testButtonAvailable() {
        // Arrange
        let button = app.buttons[buttonIdentifier]
        
        // Assert
        XCTAssertEqual(button.exists, true, Constants.TestFailMessages.buttonMissing)
    }
    
    // TODO: - Test is Button Clickable on UI
    /// UI Test to check the clicking ability of button
    /// To check if user interaction is not disabled
    /// accessibilityIdentifier = 'buttonGenerateCurrency'
    func testButtonClickable() {
        let button = app.buttons[buttonIdentifier]
        
        XCTAssertTrue(button.isEnabled, Constants.TestFailMessages.buttonNotEnabled)
        XCTAssertEqual(button.isHittable, true, Constants.TestFailMessages.buttonNotClickable)
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
        XCTAssertFalse(initialText == updatedText, Constants.TestFailMessages.labelValueNotChanged)
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
        XCTAssertTrue(currencyLabelText.contains("€"), Constants.TestFailMessages.euroSymbolMissing)
        XCTAssertTrue(currencyLabelText.contains(","), Constants.TestFailMessages.fractionDigitsMissing)
        let currencyComponents = currencyLabelText.components(separatedBy: ",")
        XCTAssertEqual(currencyComponents[1].count, 2, Constants.TestFailMessages.wrongFractionDigitsCount)
    }
    
}

