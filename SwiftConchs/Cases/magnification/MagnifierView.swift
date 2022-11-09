//
//  MagnifierView.swift
//  SimpleMagnifyingView
//
//  Created by Tomortec on 2022/4/30.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI
public struct MagnifierView<Content: View>: View {
    let content: Content
    var magnifyingGlassSize: CGSize = CGSize(width: 100.0, height: 100.0)
    var magnifyingGlassShape: AnyShape
    var glassHandleWidthRatio: CGFloat = 0.3
    var glassHandleHeight: CGFloat = 15.0
    
    var outlineColor: Color = .black
    var outlineWidth: CGFloat = 5.0
    
    var maskBackgroundColor: Color = .black.opacity(0.1)
    
    var closeButtonSize: CGSize = CGSize(width: 40.0, height: 40.0)
    var closeButtonColor: Color = .black
    
    var enableHitInMagnifyingGlass: Bool = true
    var isShowingCloseButton: Bool = true
    
    @Binding var isMagnifying: Bool
    @Binding var scale: CGFloat
    @State private var translation: CGVector = CGVector(dx: 0, dy: 0)
    @State private var position: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height / 2.0 - 60.0)
    
    public init(
        isMagnifying: Binding<Bool>,
        scale: Binding<CGFloat> = .constant(2.0),
        glassShape: AnyShape = AnyShape(RoundedRectangle(cornerRadius: 12.0)),
        @ViewBuilder _ content: () -> Content
    ) {
        self.magnifyingGlassShape = glassShape
        self._isMagnifying = isMagnifying
        self._scale = scale
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                content
                
                if isMagnifying {
                    content
                        .allowsHitTesting(enableHitInMagnifyingGlass)
                        .scaleEffect(scale, anchor: .center)
                        .position(
                            x: translation.dx * (scale - 1.0) + geometry.size.width / 2.0,
                            y: translation.dy * (scale - 1.0) + geometry.size.height / 2.0)
                        .mask(
                            magnifyingGlassShape
                                .size(magnifyingGlassSize)
                                .frame(width: magnifyingGlassSize.width, height: magnifyingGlassSize.height)
                                .position(position)
                        )
                        .contentShape(
                            magnifyingGlassShape
                                .size(magnifyingGlassSize)
                                .offset(x: position.x - magnifyingGlassSize.width / 2.0,
                                        y: position.y - magnifyingGlassSize.height / 2.0)
                        )
                    
                    MagnifyingGlass(
                        size: magnifyingGlassSize,
                        shape: magnifyingGlassShape,
                        handleWidthRatio: glassHandleWidthRatio,
                        handleHeight: glassHandleHeight,
                        position: $position,
                        translation: $translation,
                        geometry: geometry,
                        enableHitInMagnifyingView: enableHitInMagnifyingGlass
                    )
                    .outlineColor(outlineColor)
                    .outlineWidth(outlineWidth)
                }
            }
        }
    }
}

extension MagnifierView {
    
    public func magnifyingGlassSize(_ size: CGSize) -> Self {
        var copied = self
        copied.magnifyingGlassSize = size
        return copied
    }
    public func magnifyingGlassShape(_ shape: AnyShape) -> Self {
        var copied = self
        copied.magnifyingGlassShape = shape
        return copied
    }
    
    public func handleWidthRatio(_ ratio: CGFloat) -> Self {
        var copied = self
        copied.glassHandleWidthRatio = ratio
        return copied
    }
    
    public func handleHeight(_ height: CGFloat) -> Self {
        var copied = self
        copied.glassHandleHeight = height
        return copied
    }
    
    public func maskBackgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.maskBackgroundColor = color
        return copied
    }
    
    public func outlineColor(_ color: Color) -> Self {
        var copied = self
        copied.outlineColor = color
        return copied
    }
    
    public func outlineWidth(_ width: CGFloat) -> Self {
        var copied = self
        copied.outlineWidth = width
        return copied
    }
    
    public func enableHitInMagnifyingGlass(_ enabled: Bool) -> Self {
        var copied = self
        copied.enableHitInMagnifyingGlass = enabled
        return copied
    }
    
    public func enableCloseButton(_ enabled: Bool) -> Self {
        var copied = self
        copied.isShowingCloseButton = enabled
        return copied
    }
    
    public func closeButtonSize(_ size: CGSize) -> Self {
        var copied = self
        copied.closeButtonSize = size
        return copied
    }
    
    public func closeButtonColor(_ color: Color) -> Self {
        var copied = self
        copied.closeButtonColor = color
        return copied
    }
}
