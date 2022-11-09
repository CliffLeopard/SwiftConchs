//
//  MagnifyingGlass.swift
//  SimpleMagnifyingView
//
//  Created by Tomortec on 2022/4/30.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

struct MagnifyingGlass<S: Shape>: View {
    var size: CGSize
    var shape: S
    
    var outlineColor: Color = .gray
    var outlineWidth: CGFloat = 5.0
    
    var handleWidthRatio: CGFloat = 0.3
    var handleHeight: CGFloat = 15.0
    
    @Binding var position: CGPoint
    @Binding var translation: CGVector
    
    var geometry: GeometryProxy
    var enableHitInMagnifyingView: Bool
    
    @GestureState private var fingerPosition: CGPoint? = nil
    @GestureState private var startPosition: CGPoint? = nil
    
    var body: some View {
        shape
            .size(size)
            .fill(enableHitInMagnifyingView ? .clear : .white.opacity(0.01))
            .frame(width: size.width, height: size.height)
            .overlay(shape.size(size).stroke(outlineColor, lineWidth: outlineWidth))
            .position(position)
            .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global).onChanged { value in
                var newPosition = startPosition ?? position
                newPosition.x += value.translation.width
                newPosition.y += value.translation.height
                self.position = newPosition
                
                
                if self.position.x - size.width / 2.0 <= 0 {
                    self.position.x = size.width / 2.0
                } else if self.position.x + size.width / 2.0 >= geometry.size.width {
                    self.position.x = geometry.size.width - size.width / 2.0
                }
                
                var hitBottom = false
                
                if self.position.y - size.height / 2.0 <= 0 {
                    self.position.y = size.height / 2.0
                } else if self.position.y + size.height / 2.0 >= geometry.size.height + geometry.safeAreaInsets.bottom {
                    self.position.y = geometry.size.height + geometry.safeAreaInsets.bottom - size.height / 2.0
                    hitBottom = true
                }
                
                let screenCenter = CGPoint(x: geometry.size.width / 2.0, y: geometry.size.height / 2.0)
                
                withAnimation {
                    translation = screenCenter - CGPoint(x: newPosition.x, y: newPosition.y + (hitBottom ? geometry.safeAreaInsets.bottom : 0.0))
                    translation.dx = translation.dx.clamp(to: -1 * geometry.size.width / 2.0 ... geometry.size.width / 2.0)
                    translation.dy = translation.dy.clamp(to: -1 * geometry.size.height / 2.0 ... geometry.size.height / 2.0)
                }
                
            }.updating($startPosition) {
                _, startPosition, _ in
                startPosition = startPosition ?? self.position
            })
    }
}

extension MagnifyingGlass {
    func size(_ size: CGSize) -> Self {
        var copied = self
        copied.size = size
        return copied
    }
    
    func shape(_ shape: S) -> Self {
        var copied = self
        copied.shape = shape
        return copied
    }
    
    func outlineColor(_ color: Color) -> Self {
        var copied = self
        copied.outlineColor = color
        return copied
    }
    
    func outlineWidth(_ width: CGFloat) -> Self {
        var copied = self
        copied.outlineWidth = width
        return copied
    }
    
    func geometry(_ proxy: GeometryProxy) -> Self {
        var copied = self
        copied.geometry = proxy
        return copied
    }
}
