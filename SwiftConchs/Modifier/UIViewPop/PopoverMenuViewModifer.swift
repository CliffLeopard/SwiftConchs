//
//  View++.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/28.
//

import Foundation
import SwiftUI

extension View {
    public func popMenu<Container,S>(_  popId:Binding<String?>,
                                     id:String,
                                     width:CGFloat,
                                     height:CGFloat,
                                     color:S,
                                     arrowWidth:CGFloat = 12,
                                     arrowHeight:CGFloat = 6,
                                     tl:CGFloat = 4.0,
                                     tr:CGFloat = 4.0,
                                     bl:CGFloat = 4.0,
                                     br:CGFloat = 4.0,
                                     @ViewBuilder container: @escaping () -> Container) -> some View
    where Container : View,S:ShapeStyle {
        modifier(PopMenuCoverViewModifer<Container,S>(
            popId:popId,
            id:id,
            width:width,
            height: height,
            color:color,
            arrowWidth: arrowWidth, arrowHeight: arrowHeight,
            tl:tl,tr:tr, bl: bl, br: br,
            container: container))
    }
}

struct PopMenuCoverViewModifer<Container,S>: ViewModifier  where Container:View , S:ShapeStyle {
    @Binding var popId:String?
    var id:String
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
    
    @State private var menuView :UIView?
    @Environment(\.layoutDirection) var direction
    func body(content: Content) -> some View {
        return content.background(
            GeometryReader { proxy in
                let globalRect = proxy.frame(in: .global)
                let arrowDown = globalRect.minY > height + 40
                let isLeft = self.direction == .leftToRight
                EmptyView()
                    .onChange(of: self.popId) { newValue in
                        debugPrint("PodI Changed")
                        if let controller = UIViewTool.rootController() {
                            if menuView == nil {
                                let childController = UIHostingController(
                                    rootView: container()
                                        .simultaneousGesture(
                                            TapGesture().onEnded {
                                                self.popId = nil
                                                menuView?.removeFromSuperview()
                                            }
                                        )
                                        .frame(width: width, height: height, alignment: .center)
                                        .popbackground(arrowDown:arrowDown,anchorRect: globalRect, color: color,arrowWidth:arrowWidth,arrowHeight:arrowHeight,tl: tl , tr: tr, bl: bl, br: br,isLeft: self.direction == .rightToLeft)
                                    
                                    
                                )
                                self.menuView = childController.view
                            }
                            if let view = menuView {
                                if self.id == newValue {
                                    let point = popViewPosition(originRect: globalRect, popSize: CGSize(width: width, height: height), arrowDown: arrowDown,isLeft: isLeft)
                                    view.frame = CGRect(x:point.x, y:point.y, width: width, height: height)
                                    controller.view.addSubview(view)
                                    controller.view.bringSubviewToFront(view)
                                } else {
                                    view.removeFromSuperview()
                                }
                            }
                        }
                    }
            }
        )
    }
    
    func popViewPosition(originRect:CGRect, popSize:CGSize, arrowDown:Bool, isLeft:Bool) -> CGPoint {
        var x = popSize.width > originRect.width ? originRect.minX :  (originRect.midX - popSize.width/2)
        let y =  arrowDown ? ( originRect.minY - popSize.height - arrowWidth ) : (originRect.maxY + arrowHeight)
        
        if (isLeft) {
            x = popSize.width > originRect.width ? originRect.maxX - popSize.width : originRect.midX - popSize.width/2
        }
        
        return CGPoint(x:  x, y: y)
    }
}
