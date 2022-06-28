//
//  PopoverBackgroundModifer.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import Foundation
import SwiftUI

extension View {
    //popover背景View
    public func popbackground<S>(arrowDown:Bool,anchorRect:CGRect,color:S,arrowWidth:CGFloat = 12,arrowHeight:CGFloat = 6, tl:CGFloat = 4.0, tr:CGFloat = 4.0, bl:CGFloat = 4.0, br:CGFloat = 4.0, isLeft:Bool = false) -> some View where S:ShapeStyle {
        modifier(PopoverBackgroundModifer(arrowDown:arrowDown, anchorRect: anchorRect,color: color, arrowWidth: arrowWidth,arrowHeight: arrowHeight,tl:tl,tr:tr,bl:bl,br:br,isLeft: isLeft))
    }
}

public struct PopoverBackgroundModifer<S> : ViewModifier where S:ShapeStyle {
    var arrowDown:Bool
    var anchorRect:CGRect
    var color:S
    var arrowWidth:CGFloat = 12
    var arrowHeight:CGFloat = 6
    var tl: CGFloat = 4.0
    var tr: CGFloat = 4.0
    var bl: CGFloat = 4.0
    var br: CGFloat = 4.0
    var isLeft:Bool = false
    public func body(content: Content) -> some View {
        return content.background(PopShape(arrowDown:arrowDown ,anchorRect: self.anchorRect,arrowWidth: self.arrowWidth,arrowHeight: self.arrowHeight,tl:self.tl,tr:self.tr,bl:self.bl,br:self.br,isLeft: isLeft).fill(self.color))
    }
}

