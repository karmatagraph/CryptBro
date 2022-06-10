//
//  String+Extension.swift
//  CryptBro
//
//  Created by karma on 6/10/22.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
