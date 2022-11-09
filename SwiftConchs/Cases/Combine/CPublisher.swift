//
//  CPublisher.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//

import Foundation
import Combine
class CPublisher : Publisher {
    typealias Output = Int
    typealias Failure = Error
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        debugPrint("CPublisher","receive")
    }
    
//    public func subscribe<S>(_ subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
//        debugPrint("CPublisher","subscribe")
//        self.receive(subscriber: subscriber)
//    }
}
