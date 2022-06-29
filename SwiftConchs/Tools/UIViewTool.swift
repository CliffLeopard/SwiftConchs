//
//  UIViewTool.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/28.
//

import Foundation
import SwiftUI

class UIViewTool {
    static func rootController() -> UIViewController? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
    }
}
