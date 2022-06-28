//
//  CaseMultiGesture.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct CaseMultiGesture: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .multiPress {
                debugPrint("press")
            } onClick: {
                debugPrint("onClick")
            } onLongClick: {
                debugPrint("onLongClick")
            } onLongClickUp: {
                debugPrint("onLongClickUp")
            } onDragProcess: { value, direction, length in
                debugPrint("onDrag:\(direction)")
            } onSwipeProcess: { value, direction, length in
                debugPrint("onSwipeProcess:\(direction)")
            } onSwipeUp: { value in
                debugPrint("onSwipeUp")
            } onLongClickAndDragUp: { value in
                debugPrint("onLongClickAndDragUp")
            }
    }
}

struct CaseMultiGesture_Previews: PreviewProvider {
    static var previews: some View {
        CaseMultiGesture()
    }
}
