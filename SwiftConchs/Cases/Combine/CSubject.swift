//
//  CSubject.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//  内置两种 PassthrougSubject，CurrentValueSubject
//

import Foundation
import Combine

class CSubject: Subject {
    typealias Output = Int
    typealias Failure = Error
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        debugPrint("CSubject","receive")
    }
    
    func send(_ value: Output) {
        debugPrint("CSubject","send1")
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
        debugPrint("CSubject","send2")
    }
    
    func send(subscription: Subscription) {
        debugPrint("CSubject","send3")
    }
}
