//
//  CaseSink.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/13.
//

import Foundation
import Combine

struct CaseSink {
    static  func case1() {
        let publisher =  Array(0..<1000)
            .publisher
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.global())
            .map({ return ("kk", String($0))})
            .debounce(for: 0.5, scheduler: DispatchQueue.global())
            .sink { completion in
                debugPrint("completion",completion, Thread.current.isMainThread, Thread.current.name ?? "empty")
            } receiveValue: { result in
                debugPrint("result",result, Thread.current.isMainThread, Thread.current.name ?? "empty")
            }
        debugPrint("before cancel",Thread.current.isMainThread, Thread.current.name ?? "empty")
//        publisher.cancel()
        debugPrint("after cancel",Thread.current.isMainThread, Thread.current.name ?? "empty")
    }
}
