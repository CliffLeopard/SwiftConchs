//
//  TaskState.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/8.
//

import Foundation
import SwiftUI

enum TaskState: String {
    case notwork = "未工作"
    case waiting = "等待中"
    case woring  = "进行中"
    case fail    = "已失败"
    case success = "已成功"
    case complet = "已完成"

    func color() -> Color {
        switch self {
        case .notwork:
            return Color.black
        case .waiting:
            return Color.orange
        case .woring:
            return Color.purple
        case .fail:
            return Color.red
        case .success:
            return Color.green
        case .complet:
            return Color.cyan
        }
    }
}
