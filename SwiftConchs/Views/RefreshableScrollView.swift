//
//  RefreshableScrollView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//  下拉刷新ScrolView
//

import SwiftUI

struct RefreshableScrollView<Content: View>: View {
    @Binding var refreshing: Bool
    @State private var previousScrollOffset: CGFloat = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var frozen: Bool = false
    @State private var rotation: Angle = .degrees(0)
    @State private var isFirst: Bool = true
    
    let axes: Axis.Set
    @Binding var contentOffset: CGFloat
    
    var threshold: CGFloat = 80
    let content: Content
    init(height: CGFloat = 80, axes: Axis.Set = .vertical,  refreshing: Binding<Bool>, contentOffset: Binding<CGFloat>,  @ViewBuilder content: () -> Content) {
        self.threshold = height
        self.axes = axes
        self._refreshing = refreshing
        self._contentOffset = contentOffset
        self.content = content()
    }
    
    var body: some View {
        return VStack {
            GeometryReader { outProxy in
                ScrollView(self.axes, showsIndicators: false) {
                    ZStack(alignment: self.axes == .vertical ?.top : .leading) {
                        GeometryReader { inProxy in
                            Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: [self.caclulateContentOffset(outsideProxy: outProxy, insideProxy: inProxy)])
                        }
                        MovingView()
                        VStack {
                            self.content
                        }
                        .alignmentGuide(.top, computeValue: { d in
                            (self.refreshing && self.frozen) ? -self.threshold : 0.0
                        })
                        
                        SymbolView(height: self.threshold, loading: self.refreshing, frozen: self.frozen, rotation: self.rotation)
                    }
                }
                .background(FixedView())
                .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
                    self.refreshLogic(values: values)
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) {value in
                    self.contentOffset = value[0]
                }
            }
        }
    }
    
    private func caclulateContentOffset(outsideProxy:GeometryProxy, insideProxy:GeometryProxy) ->CGFloat {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
    
    func refreshLogic(values: [RefreshableKeyTypes.PrefData]) {
        DispatchQueue.main.async {
            let movingBounds = values.first { $0.vType == .movingView }?.bounds ?? .zero
            let fixedBounds = values.first { $0.vType == .fixedView }?.bounds ?? .zero
            self.scrollOffset  = movingBounds.minY - fixedBounds.minY
            self.rotation = self.symbolRotation(self.scrollOffset)
            
            if !self.refreshing && (self.scrollOffset > self.threshold && self.previousScrollOffset <= self.threshold) {
                if isFirst {
                    isFirst = false
                } else {
                    self.refreshing = true
                }
            }
            
            if self.refreshing {
                if self.previousScrollOffset > self.threshold && self.scrollOffset <= self.threshold {
                    self.frozen = true
                }
            } else {
                self.frozen = false
            }
            
            self.previousScrollOffset = self.scrollOffset
        }
    }
    
    func symbolRotation(_ scrollOffset: CGFloat) -> Angle {
        if scrollOffset < self.threshold * 0.60 {
            return .degrees(0)
        } else {
            let h = Double(self.threshold)
            let d = Double(scrollOffset)
            let v = max(min(d - (h * 0.6), h * 0.4), 0)
            return .degrees(180 * v / (h * 0.4))
        }
    }
    
    struct SymbolView: View {
        var height: CGFloat
        var loading: Bool
        var frozen: Bool
        var rotation: Angle
        
        var body: some View {
            Group {
                if self.loading {
                    VStack {
                        Spacer()
                        ActivityRep()
                        Spacer()
                    }.frame(height: height).fixedSize()
                        .offset(y: -height + (self.loading && self.frozen ? height : 0.0))
                } else {
                    Image(systemName: "circle.dashed")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: height * 0.25, height: height * 0.25).fixedSize()
                        .padding(height * 0.375)
                        .rotationEffect(rotation)
                        .offset(y: -height + (loading && frozen ? +height : 0.0))
                }
            }
        }
    }
    
    struct MovingView: View {
        var body: some View {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: RefreshableKeyTypes.PrefKey.self,
                                value: [RefreshableKeyTypes.PrefData(vType: .movingView, bounds: proxy.frame(in: .global))])
            }.frame(height: 0)
        }
    }
    
    struct FixedView: View {
        var body: some View {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: RefreshableKeyTypes.PrefKey.self,
                                value: [RefreshableKeyTypes.PrefData(vType: .fixedView, bounds: proxy.frame(in: .global))])
            }
        }
    }
}

struct RefreshableKeyTypes {
    enum ViewType: Int {
        case movingView
        case fixedView
    }
    
    struct PrefData: Equatable {
        let vType: ViewType
        let bounds: CGRect
    }
    
    struct PrefKey: PreferenceKey {
        static var defaultValue: [PrefData] = []
        
        static func reduce(value: inout [PrefData], nextValue: () -> [PrefData]) {
            value.append(contentsOf: nextValue())
        }
        
        typealias Value = [PrefData]
    }
}

struct ScrollOffsetPreferenceKey:PreferenceKey {
    typealias Value = [CGFloat]
    static var defaultValue: [CGFloat] = [0.0]
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

struct ActivityRep: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityRep>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityRep>) {
        uiView.startAnimating()
    }
}

