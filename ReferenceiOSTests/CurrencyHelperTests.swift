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
        XCTAssertEqual(result, "€ 1.234.567.890,12", "Couldn't format properly")
    }
    
    // TODO: - Test for small number
    func testSmallNumber() {
        // Arrange (Given)
        let number: NSNumber = 0.01
        
        // Act (When)
        let result = CurrencyHelper.format(amount: number)
        
        // Assert (Then)
        XCTAssertEqual(result, "€ 0,01")
    }
    
    // Extra test cases considering if input type is textBox insead of number generating randomly
    // TODO: - Test for invalid number
    func testInvalidNumber() {
        // Arrange (Given)
        let number: NSNumber = -10
        
        // Act (When)
        let result = CurrencyHelper.format(amount: number)
        
        // Assert (Then)
        XCTAssertEqual(result, "€ -10,00", "invalid input, currency shouldn't be a negative number")
    }
    
    // TODO: - Test for invalid number
    // given range 100 - 99999999
    func testIBelowRange() {
        // Arrange (Given)
        let number: NSNumber = 99.95
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        
        formatter.string(from: number)
        
            
        // Act (When)
        let result: String = CurrencyHelper.format(amount: number) ?? ""
        let currencyString: String = result.currencyWithoutSymbol()
        
        let numberString = formatter.number(from: currencyString)
        
        let compare = (numberString as! Double) < Double(100.00)
        
        // Assert (Then)
        XCTAssertTrue(compare, "Number is below 100")
    }
    
    //TODO: UI Attribution Test >>
    func testAttribution() {
        // Test with a known formatted amount
        let formattedAmount = "€ 1.234.569,78"
        let attributedString = CurrencyHelper.attributify(amount: formattedAmount)
        
        let startRange = 0
        let centRange = 2
        let euroRange = (attributedString.length - centRange)

        // Check if the attributed string has the correct attributes
        attributedString.enumerateAttributes(in: NSRange(location: startRange, length: attributedString.length), options: []) { (attributes, range, _) in
            
            if range.location < euroRange {
                XCTAssertEqual(attributes[.font] as? UIFont, UIFont(name: "Helvetica", size: 18), "Regular font size should be Helvetica - 18.0")
            }
            
            if range.location >= euroRange {
                XCTAssertEqual(attributes[.baselineOffset] as? CGFloat, 3.0, "Superscript font baseline 3")
                XCTAssertEqual(attributes[.font] as? UIFont, UIFont(name: "Helvetica", size: 13), "Superscript font should be Helvetica - 13.0")
            }
        }
    }
    
}

extension String {
    func currencyWithoutSymbol() -> String {
        let valueString = self.filter {
            CharacterSet(charactersIn: "0123456789.,").isSuperset(of: CharacterSet(charactersIn: String($0)))
        }.trimmingCharacters(in: .whitespacesAndNewlines)
        return valueString
    }
}
