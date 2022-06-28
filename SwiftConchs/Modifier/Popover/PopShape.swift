//
//  PopShape.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import Foundation
import SwiftUI

struct PopShape : Shape {
    var arrowDown:Bool
    var anchorRect:CGRect
    var arrowWidth:CGFloat = 12
    var arrowHeight:CGFloat = 6
    var tl: CGFloat = 4.0
    var tr: CGFloat = 4.0
    var bl: CGFloat = 4.0
    var br: CGFloat = 4.0
    var isLeft: Bool = false
    @Environment(\.layoutDirection) var direction
    func path(in rect: CGRect) -> Path {
        Path { path in
            let w = rect.size.width
            let h = rect.size.height
            let arrowPosition = arrowPosition(originRect: anchorRect, popRect: rect)
            
            let tr = min(min(self.tr, h/2), w/2)
            let tl = min(min(self.tl, h/2), w/2)
            let bl = min(min(self.bl, h/2), w/2)
            let br = min(min(self.br, h/2), w/2)
            
            // 上边
            path.move(to: CGPoint(x: w / 2.0, y: 0))
            if !arrowDown {
                path.addLine(to: CGPoint(x:arrowPosition,y: 0))
                path.addLine(to: CGPoint(x: arrowPosition + arrowWidth/2, y: -arrowHeight))
                path.addLine(to: CGPoint(x: arrowPosition + arrowWidth, y: 0))
            }
            path.addLine(to: CGPoint(x: w - tr, y: 0))
            
            // 右上角
            path.addArc(
                center: CGPoint(x: w - tr, y: tr),
                radius: tr,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )
            // 右边
            path.addLine(to: CGPoint(x: w, y: h - br))
            // 右下角
            path.addArc(
                center: CGPoint(x: w - br, y: h - br),
                radius: br,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )
            // 下边
            if arrowDown {
                path.addLine(to: CGPoint(x: arrowPosition + arrowWidth, y: h))
                path.addLine(to: CGPoint(x: arrowPosition + arrowWidth/2, y: h+arrowHeight))
                path.addLine(to: CGPoint(x: arrowPosition, y: h))
            }
            
            path.addLine(to: CGPoint(x: bl, y: h))
            
            // 左下角
            path.addArc(
                center: CGPoint(x: bl, y: h - bl),
                radius: bl,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            // 左边
            path.addLine(to: CGPoint(x: 0, y: tl))
            // 作下角
            path.addArc(
                center: CGPoint(x: tl, y: tl),
                radius: tl,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
        }
    }
    
    func arrowPosition(originRect:CGRect, popRect:CGRect) -> CGFloat {
        let originSize = originRect.size
        let popSize = popRect.size
        if originSize.width > popSize.width {
            return popSize.width / 2 - arrowWidth/2
        } else {
            if isLeft {
                return  originSize.width / 2 - arrowWidth/2
            } else {
                return abs(popSize.width - originSize.width / 2) - arrowWidth/2
            }
        }
    }
}
