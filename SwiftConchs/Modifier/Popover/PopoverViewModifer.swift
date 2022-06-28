//
//  PopoverViewModifer.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//


import Foundation
import SwiftUI

extension View {
    // 设定锚点，绘制Popover视图
    public func popover<Container,S>(_ present:Binding<Bool>,
                                     width:CGFloat,height:CGFloat,color:S,
                                     arrowWidth:CGFloat = 12,arrowHeight:CGFloat = 6,
                                     tl:CGFloat = 4.0, tr:CGFloat = 4.0, bl:CGFloat = 4.0, br:CGFloat = 4.0,
                                     @ViewBuilder container: @escaping () -> Container) -> some View where Container : View,S:ShapeStyle {
        
        modifier(PopoverViewModifer<Container,S>(present:present,width:width, height: height, color:color,
                                                 arrowWidth: arrowWidth, arrowHeight: arrowHeight,
                                                 tl:tl,tr:tr, bl: bl, br: br,
                                                 container: container))
    }
    
}

public struct PopoverViewModifer<Container,S>: ViewModifier  where Container : View,S:ShapeStyle {
    @Binding var present:Bool
    var width:CGFloat
    var height:CGFloat
    var color:S
    var arrowWidth:CGFloat = 12
    var arrowHeight:CGFloat = 6
    var tl: CGFloat = 4.0
    var tr: CGFloat = 4.0
    var bl: CGFloat = 4.0
    var br: CGFloat = 4.0
    var container:() -> Container
    let bounds = UIScreen.main.bounds
    
    @Environment(\.layoutDirection) var direction
    public func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                let rect = proxy.frame(in: .local)
                let globalRect = proxy.frame(in: .global)
                let arrowDown = globalRect.minY > height + 40
                if self.present && globalRect.minY > 40 {
                    container()
                        .environment(\.layoutDirection, .leftToRight)
                        .frame(width: width, height: height)
                        .popbackground(arrowDown:arrowDown,anchorRect: rect, color: color,arrowWidth:arrowWidth,arrowHeight:arrowHeight,tl: tl , tr: tr, bl: bl, br: br,isLeft: self.direction == .rightToLeft)
                        .position(popViewPosition(originRect: rect,globalRect:globalRect, popSize: CGSize(width: width, height: height),arrowDown:arrowDown))
                } else {
                    EmptyView()
                }
            }
        )
    }
    
    func popViewPosition(originRect:CGRect, globalRect:CGRect,  popSize:CGSize, arrowDown:Bool) -> CGPoint {
        var x = originRect.midX
        let y =  arrowDown ? (originRect.minY - popSize.height/2 - arrowHeight) :  (originRect.maxY + popSize.height/2 + arrowHeight)
        if popSize.width > originRect.size.width {
            x = originRect.maxX - popSize.width/2
        }
        debugPrint("globalRect.minY",globalRect.minY,popSize.height)
        return CGPoint(x: x, y: y)
    }
}

