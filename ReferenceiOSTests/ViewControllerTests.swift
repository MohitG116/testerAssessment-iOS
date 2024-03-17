//
//  ViewControllerTests.swift
//  ReferenceiOSTests
//
//  Created by User1 on 14/03/24.
//  Copyright © 2024 ABN AMRO. All rights reserved.
//

import XCTest
import Foundation
@testable import ReferenceiOS

class ViewControllerTests: XCTestCase {
    
    var VC: ViewController!
    var minCurrency: CGFloat = 100
    var maxCurrency: CGFloat = 99999999
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        VC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        VC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        VC = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    // TODO: Test Currency label Text changed
    /// Check if Label default value is changed
    /// from "Hello" to any generated currency value
    func testLabelTextChanged() {
        // Given
        let defaultText = "Hello"
        
        // When
        VC.generate(VC.button)
        let currencyLabel = VC.label.text
        
        // Then
        XCTAssertNotEqual(currencyLabel, defaultText, "Currency label text not updated from \'Hello\' to generated currency.")
    }
    
    // TODO: Test Generated Currency is within the range
    /// Ensures that a function retuerns a valid random number
    /// between 100 & 99999999
    /// Testing for a single generated Currency Value
    func testCurrencyInRange() {
        
        // When
        VC.generate(VC.button)
        let currencyLabel = VC.label.text
        let generatedCurrency: CGFloat? = currencyLabel?.numberfromString()
        
        // Then
        XCTAssertGreaterThanOrEqual(generatedCurrency ?? 0.0, minCurrency, "Generated Number is less than Min value.")
        XCTAssertLessThanOrEqual(generatedCurrency ?? 0.0, maxCurrency, "Generated Number is greater than Max value.")
    }
    
    // TODO: Test Generated Currency is within the range repeteadly
    /// Test calling the funciton repeatedly 1000 times
    /// ensuring it always generates a number within the range
    func testRepeatedlyCurrencyInRange() {
        
        // When
        for _ in 1...1000 {
            VC.generate(VC.button)
            let currencyLabel = VC.label.text
            let generatedCurrency = currencyLabel?.numberfromString()
            
            // Then
            XCTAssertGreaterThanOrEqual(generatedCurrency ?? 0.0, minCurrency, "Generated Number is less than Min value.")
            XCTAssertLessThanOrEqual(generatedCurrency ?? 0.0, maxCurrency, "Generated Number is greater than Max value.")
        }
    }
    
    // MARK: - Testing Boundary Condition
    // TODO: Test Generated Currency Boundary Condition
    /// Test calling the funciton repeatedly 1000 times
    /// Ensuring it never generates a number outside of the boundary
    func testBoundaryValues() {
        // Given
        var counts = [CGFloat]()
        let iterations = 1000
        
        // When
        for _ in 0...iterations {
            VC.generate(VC.button)
            let currencyLabel = VC.label.text
            let generatedCurrency = currencyLabel?.numberfromString()
            
            counts.append(generatedCurrency ?? 0.0)
        }
        
        // Then
        XCTAssertFalse(counts.contains(minCurrency - 1), "Generated Number is less than lower boundary.")
        XCTAssertFalse(counts.contains(maxCurrency + 1), "Generated Number is greater than upper boundary.")
    }
    
    // TODO: - Test generation of formatted currency
    /// Test if generated currency is formated as expected
    /// Currency should contain '€' symbol followed by space
    /// Follow the currency seperator as per given Locale [nl_NL]
    func testIsGeneratedAmountFormatted() {
        // Given
        let currencyRegex = "^(€\\s)(?!0\\d)\\d{1,3}(?:\\.\\d{3})*,\\d{2}$"
        
        // When
        VC.generate(VC.button)
        let currencyLabelString = VC.label.text
        let isMatch: Bool = ((currencyLabelString?.matches(currencyRegex)) != nil)
        
        // Then
        XCTAssertTrue(isMatch, "Generated currency is not in \'nl_NL\' currency format.")
    }
    
    // TODO: - Test Performance of Currency Generation Method
    /// Try ececuting the function 100000 time
    /// Check completion time, if it fail
    /// Avg completion time is ~6.1 Sec ✅
    func testPerformance () {
        measure {
            for _ in 1...100000 {
                VC.generate(VC.button)
            }
        }
    }
}
