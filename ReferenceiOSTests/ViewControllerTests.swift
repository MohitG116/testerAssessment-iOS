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
    
    // TODO: - Test currency label Text changed
    func testBoundryCurrency() {
        // Given
        let defaultText = "Hello"
        
        // When
        VC.generate(VC.button)
        
        // Then
        let currencyLabel = VC.label.text
        XCTAssertNotEqual(currencyLabel, defaultText, "Currency label text is still Hello")
    }
    
    // TODO: - Test Boundary Currency Number range
    /// Ensures that a function retuerns a valid random number in expected range
    func testValidCurrencyInRange() {
        
        // When
        VC.generate(VC.button)
        let currencyLabel = VC.label.text
        let generatedCurrency: NSNumber? = currencyLabel?.numberfromString()
                
        // Then
        XCTAssertGreaterThanOrEqual(generatedCurrency as! CGFloat, minCurrency, "Generated Number is less than Min value.")
        XCTAssertLessThanOrEqual(generatedCurrency as! CGFloat, maxCurrency, "Generated Number is greater than Max value.")
    }
    
    // TODO: - Test Currency Number range
    /// Test calling the funciton repeatedly 1000 times
    /// ensuring it always generates a number within the range
    func testRepeatedlyCurrencyInRange() {
        
        // When
        for _ in 1...1000 {
            VC.generate(VC.button)
            let currencyLabel = VC.label.text
            let generatedCurrency: NSNumber? = currencyLabel?.numberfromString()
                    
            // Then
            XCTAssertGreaterThanOrEqual(generatedCurrency as! CGFloat, minCurrency, "Generated Number is less than Min value.")
            XCTAssertLessThanOrEqual(generatedCurrency as! CGFloat, maxCurrency, "Generated Number is greater than Max value.")
        }
    }
   
    // TODO: - Test generation of formatted currency
    /// Test calling the funciton repeatedly 1000 times
    /// ensuring it always generates a number within the range
    func testIsGeneratedAmountFormatted() {
        // Given
        let currencyRegex = "^(€\\s)(?!0\\d)\\d{1,3}(?:\\.\\d{3})*,\\d{2}$"
        
        // When
        VC.generate(VC.button)
        let currencyLabelString = VC.label.text
        let isMatch: Bool = ((currencyLabelString?.matches(currencyRegex)) != nil)
        
        // Then
        XCTAssertTrue(isMatch, "Generated currency is not in nl_NL currency format.")
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
    
    // TODO: -
    func testGenerateButtonTapped() {
        let currencyRegex = "^(€\\s)(?!0\\d)\\d{1,3}(?:\\.\\d{3})*,\\d{2}$"
        VC.generate(VC.button)
        
        XCTAssertTrue(((VC.label.text?.matches(currencyRegex)) != nil))
    }
    
}
