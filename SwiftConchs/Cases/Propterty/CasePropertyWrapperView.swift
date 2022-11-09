//
//  CasePropertyWrapperView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/8.
//

import SwiftUI

struct CasePropertyWrapperView: View {
    @State var realName = false
    
    init() {
        debugPrint("CasePropertyWrapperView init()")
    }
    
    var body: some View {
        VStack {
            Button {
                self.realName.toggle()
            } label: {
                Text("Toggle Name")
            }
            Text(realName ? "GGL" : "Cliff").padding()
            
            SonView().padding()
            
            NavigationLink("AsyncFun") {
                AsyncFucView()
            }
            
        }.onAppear{
            debugPrint("CasePropertyWrapperView OnAppear")
        }.onDisappear{
            debugPrint("CasePropertyWrapperView onDisappear")
        }
    }
}

struct SonView:View {
    @StateObject var performance:Performance = Performance()
    @State private var niceScore = false
    
    init() {
        debugPrint("SonView init()")
    }
    
    var body: some View {
        VStack {
            Button("Score Add One ") {
                performance.score += 1
                if performance.score > 3 {
                    niceScore = true
                }
            }
            Text("Score: \(performance.score)")
            Text("Nice?  \(niceScore ? "YES" : "NO")")
            Text("Nice?  \(performance.score > 3 ? "YES" : "NO")")
        }.onAppear{
            debugPrint("SonView OnAppear")
        }.onDisappear{
            debugPrint("SonView onDisappear")
        }
    }
}

struct CasePropertyWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        CasePropertyWrapperView()
    }
}
