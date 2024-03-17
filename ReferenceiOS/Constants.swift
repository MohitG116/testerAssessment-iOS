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
        static let labelTextNotChanged = "Currency label text not updated from \'Hello\' to generated currency."
        static let belowRange = "Generated Number is less than Min value."
        static let beyondRange = "Generated Number is greater than Max value."
        
        static let belowBoundry = "Generated Number is less than lower boundary."
        static let beyondBoundry = "Generated Number is greater than upper boundary."
        
        static let currencyNotInFormat = "Generated currency is not in \'nl_NL\' currency format."
        
        
    }
}
