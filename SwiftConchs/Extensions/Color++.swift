//
//  Color++.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        
        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
    
    static func newCGColor(_ hex: UInt, alpha: Double = 1) ->CGColor {
        return CGColor(
            srgbRed: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: alpha
        )
    }
}


extension UIColor {
    convenience init(_ hex: UInt, alpha: CGFloat = 1) {
        self.init(
            displayP3Red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: alpha
        )
    }
}
