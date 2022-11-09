//
//  Performance.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/8.
//

import Foundation

class Performance: ObservableObject {
    init() {
        debugPrint("Performance Call Init")
    }
    
    @Published var score:Int = 0
    
   
    deinit {
        debugPrint("Performance Call DeInit")
    }
}
