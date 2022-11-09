//
//  MagnifierExampleView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/11/9.
//

import SwiftUI

struct MagnifierExampleView: View {
    @State var isMagnifying = true
    let bounds = UIScreen.main.bounds
    var body: some View {
//        MagnifierView(
//            isMagnifying: self.$isMagnifying,
//            glassShape: AnyShape(Circle())) {
//                Image("doc")
//                    .resizable()
//                    .scaledToFit()
//            }
//            .enableCloseButton(false)
        
        Image("doc")
            .resizable()
            .scaledToFit()
            .magifierGlass(showMag: self.isMagnifying)
    }
}

struct MagnifierExampleView_Previews: PreviewProvider {
    static var previews: some View {
        MagnifierExampleView()
    }
}
