//
//  UIApplication+Extension.swift
//  CryptBro
//
//  Created by karma on 6/8/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
