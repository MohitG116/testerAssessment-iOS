//
//  CurrencyHelperTests.swift
//  ReferenceiOSTests
//
//  Created by Dunya Kirkali on 27/03/2019.
//  Copyright © 2019 ABN AMRO. All rights reserved.
//

import XCTest
@testable import ReferenceiOS

class CurrencyHelperTests: XCTestCase {
    func testFormatRounding() {
        let number: NSNumber = 129.999
        let result = CurrencyHelper.format(amount: number)
        
        XCTAssertEqual(result, "€ 130,00")
    }
    
    func testFormatRegular() {
        let number: NSNumber = 122
        let result = CurrencyHelper.format(amount: number)
        
        XCTAssertEqual(result, "€ 122,00")
    }
    
    func testFormatDecimals() {
        let number: NSNumber = 122.50
        let result = CurrencyHelper.format(amount: number)
        
        XCTAssertEqual(result, "€ 122,50")
    }
    
    // MARK: - New Test Cases here >>
    
    // TODO: - Test for large number
    func testLargeNumber() {
        // Arrange (Given)
        let number: NSNumber = 1234567890.12
        
        // Act (When)
        let result = CurrencyHelper.format(amount: number)
        
        // Assert (Then)
        XCTAssertEqual(result, "€ 1.234.567.890,12", Constants.TestFailMessages.currencyNotInFormat)
    }
    
    // TODO: - Test for small number
    func testSmallNumber() {
        // Arrange (Given)
        let number: NSNumber = 0.01
        
        // Act (When)
        let result = CurrencyHelper.format(amount: number)
        
        // Assert (Then)
        XCTAssertEqual(result, "€ 0,01", Constants.TestFailMessages.currencyNotInFormat)
    }
    
    func testNegativeNumber() {
        // Arrange (Given)
        let number: NSNumber = -10
        
        // Act (When)
        let result = CurrencyHelper.format(amount: number)
        
        // Assert (Then)
        XCTAssertEqual(result, "€ -10,00", Constants.TestFailMessages.currencyNotInFormat)
    }
    
    // TODO: Trying giving invalid double number
    /// Giving invalid input as "nan"
    func testInvalidInput() {
        // Arrange (Given)
        let invalidNumber = NSNumber(value: Double.nan)
        
        // Act (When)
        let formattedNumber = CurrencyHelper.format(amount: invalidNumber)
        
        // Then
        XCTAssertNil(formattedNumber)
    }
    
    // TODO: Measure performance of the function
    /// Testing the performance of the format function
    /// Avg completion time is ~0.001 Sec ✅
    func testPerformance() {
        let number: NSNumber = 87654321.99
        measure {
            _ = CurrencyHelper.format(amount: number)
        }
    }
    
    //TODO: UI Attribution Test
    /// Check attributifiation of the complete string
    /// Checking RegularString Attribues
    /// Checking SperString Attributes with baseline
    func testAttribution() {
        // Given
        let formattedAmount = "€ 1.234.569,78"
        let regularSize: CGFloat = 18
        let superscriptSize: CGFloat = 13
        let startRange = 0
        let centRange = 2
        
        // When
        let attributedString = CurrencyHelper.attributify(amount: formattedAmount)
        let euroRange = (attributedString.length - centRange)
        
        // Then
        // Check if the attributed string has the correct attributes
        attributedString.enumerateAttributes(in: NSRange(location: startRange, length: attributedString.length), options: []) { (attributes, range, _) in
            
            //for Euro part
            if range.location < euroRange {
                XCTAssertEqual(attributes[.font] as? UIFont, UIFont(name: "Helvetica", size: regularSize), Constants.TestFailMessages.incorrectSuperscriptFont)
            }
            
            //for Cent part
            if range.location >= euroRange {
                XCTAssertEqual(attributes[.baselineOffset] as? CGFloat, 3.0, Constants.TestFailMessages.incorrectSuperscriptBaseline)
                XCTAssertEqual(attributes[.font] as? UIFont, UIFont(name: "Helvetica", size: superscriptSize), Constants.TestFailMessages.incorrectSuperscriptFont)
            }
        }
    }
    
    // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
#warning("This test would work if the function \"Attributify(String)\" is handled for empty string")
    func testEmptyInput() {
        //let result = CurrencyHelper.attributify(amount: "")
        //XCTAssertThrowsError(try CurrencyHelper.attributify(amount: "")) {error in
        //XCTAssertEqual(error as? Constants.AttributifyError, .emptyString, "Empty string not handeled.")
    }
    
}
