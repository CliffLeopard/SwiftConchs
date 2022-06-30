//
//  CaseMultiGesture.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct CaseMultiGesture: View {
    @State var state:PressState = .none
    
    @State var isDraging = false
    var body: some View {
        VStack {
            HStack {
                Text("Click").foregroundColor(state == .click ? Color.purple : Color.gray)
                Text("Press").foregroundColor(state == .press ? Color.purple : Color.gray)
            }
            
            HStack{
                Text("LongPressDown").foregroundColor(state == .longPressDown ? Color.purple : Color.gray)
                Text("LongPressUp").foregroundColor(state == .longPressUp ? Color.purple : Color.gray)
            }
            
            
            HStack {
                Text("DragFinish").foregroundColor(state == .dragFinish ? Color.purple : Color.gray)
                Text("SwipeFinish").foregroundColor(state == .swipeFinish ? Color.purple : Color.gray)
            
            }
            
            HStack {
                Text("DragUp").foregroundColor(state == .dragUp ? Color.purple : Color.gray)
                Text("SwipeUp").foregroundColor(state == .swipeUp ? Color.purple : Color.gray)
            }
            
            HStack {
                Text("DragLeft").foregroundColor(state == .dragLeft ? Color.purple : Color.gray)
                Text("SwipeLeft").foregroundColor(state == .swipeLeft ? Color.purple : Color.gray)
                
                Text("MultiPressMe")
                    .frame(width: 120, height: 80, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .multiPress {
                        self.state = .press
                    } onClick: {
                        self.state = .click
                    } onLongClick: {
                        self.state = .longPressDown
                    } onLongClickUp: {
                        self.state = .longPressUp
                    } onDragProcess: { value, direction, length in
                        self.isDraging = true
                        switch direction {
                        case .up:
                            self.state = .dragUp
                        case .down:
                            self.state = .dragDown
                        case .left:
                            self.state = .dragLeft
                        case .right:
                            self.state = .dragRight
                        case .none:
                            self.state = .none
                        }
                    } onSwipeProcess: { value, direction, length in
                        switch direction {
                        case .up:
                            self.state = .swipeUp
                        case .down:
                            self.state = .swipeDown
                        case .left:
                            self.state = .swipeLeft
                        case .right:
                            self.state = .swipteRight
                        case .none:
                            self.state = .none
                        }
                    } onSwipeUp: { value in
                        self.state = .swipeFinish
                    } onLongClickAndDragUp: { value in
                        self.state = self.isDraging ? .dragFinish :.longPressUp
                        self.isDraging = false
                    }
                Text("SwipeRight").foregroundColor(state == .swipteRight ? Color.purple : Color.gray)
                Text("DragRight").foregroundColor(state == .dragRight ? Color.purple : Color.gray)
            }
            
            HStack{
                Text("SwipeDown").foregroundColor(state == .swipeDown ? Color.purple : Color.gray)
                Text("DragDown").foregroundColor(state == .dragDown ? Color.purple : Color.gray)
            }
            
            Spacer()
        }
        .font(.system(size: 12))
    }
}

enum PressState {
    case none
    case press
    case click
    case dragUp
    case dragDown
    case dragLeft
    case dragRight
    case dragFinish
    case longPressDown
    case longPressUp
    case swipeUp
    case swipeDown
    case swipeLeft
    case swipteRight
    case swipeFinish
}

struct CaseMultiGesture_Previews: PreviewProvider {
    static var previews: some View {
        CaseMultiGesture()
    }
}
