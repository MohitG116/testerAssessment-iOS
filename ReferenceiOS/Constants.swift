//
//  Constants.swift
//  ReferenceiOS
//
//  Created by User1 on 17/03/24.
//  Copyright © 2024 ABN AMRO. All rights reserved.
//

import Foundation
import UIKit


struct Constants {
    
    struct TestFailMessages {
        // ViewControllerTests >>>>>>>
        static let labelTextNotChanged = "Currency label text not updated from \'Hello\' to generated currency."
        static let belowRange = "Generated Number is less than Min value."
        static let beyondRange = "Generated Number is greater than Max value."
        
        static let belowBoundry = "Generated Number is less than lower boundary."
        static let beyondBoundry = "Generated Number is greater than upper boundary."
        
        static let currencyNotInFormat = "Generated currency is not in \'nl_NL\' currency format."
        
        // ReferenceiOSUITestes >>>>>>>
        static let labelMissing = "Could not find the label to display the currency."
        static let buttonMissing = "Could not find the button to generate the currency."
        
        static let buttonNotEnabled = "Generate currency button is not enabled."
        static let buttonNotClickable = "Generate currency button is not clickable."
        
        static let labelWidthOverflow = "Label content width is larger than device view."
        static let labelValueNotChanged = "Currency label value not changed on generate button click."
        
        
        static let euroSymbolMissing = "\'nl_NL\' currency symbol is missing."
        static let fractionDigitsMissing = "Fraction Digits are missing as per \'nl_NL\' currency format."
        static let wrongFractionDigitsCount = "Incorrect fraction digits count."
       
        
        // Currency HelperTests
        static let invalidNegativeInput = "Invalid input, currency shouldn't be a negative number."
        static let incorrectRegularFont = "Regular font size should be Helvetica - 18.0"
        static let incorrectSuperscriptFont = "Superscript font should be Helvetica - 13.0"
        static let incorrectSuperscriptBaseline = "Superscript font baseline 3"
    }
}
