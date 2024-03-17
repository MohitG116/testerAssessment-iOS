//
//  TestUtility.swift
//  ReferenceiOS
//
//  Created by User1 on 16/03/24.
//  Copyright © 2024 ABN AMRO. All rights reserved.
//

import Foundation

extension String {
    
    func numberfromString() -> CGFloat? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        return (formatter.number(from: self) as? CGFloat)
    }
    
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
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

