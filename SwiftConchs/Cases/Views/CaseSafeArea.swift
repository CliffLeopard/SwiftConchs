//
//  CaseSafeArea.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/6.
//

import SwiftUI

struct CaseSafeArea: View {
    @State var isLand = false
    let orientationPublisher = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Text("Hello Word")
                Button {
                    UIApplication.shared.isPortrait(self.isLand)
                } label: {
                    Text(self.isLand ? "竖屏" :"全屏")
                }
            }.foregroundColor(Color.white)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(self.isLand ? .all : .top)
        .onReceive(orientationPublisher) { _ in
            let windowScene = UIApplication.shared.windows.first?.windowScene
            self.isLand = windowScene?.interfaceOrientation.isLandscape ?? false
        }
    }
}

extension UIApplication {
    // 是否竖屏
    func isPortrait(_ isP:Bool = true) {
        if isP {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        } else {
            // 横屏
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }
    }
}

struct CaseSafeArea_Previews: PreviewProvider {
    static var previews: some View {
        CaseSafeArea()
    }
}
