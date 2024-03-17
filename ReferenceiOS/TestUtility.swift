//
//  TestUtility.swift
//  ReferenceiOS
//
//  Created by User1 on 16/03/24.
//  Copyright © 2024 ABN AMRO. All rights reserved.
//

import Foundation

extension String {
    
    // Get the currency number from currency String
    func numberfromString() -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        return (formatter.number(from: self) as? CGFloat)
    }
    
    // Match a string with the given regex
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    // Get the currenct string without any currency symbol
    func currencyWithoutSymbol() -> String {
        let valueString = self.filter {
            CharacterSet(charactersIn: "0123456789.,").isSuperset(of: CharacterSet(charactersIn: String($0)))
        }.trimmingCharacters(in: .whitespacesAndNewlines)
        return valueString
    }
}

extension NSNumber {
    func stringfromNumber() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: self) ?? "€ 10,0"
    }
}

