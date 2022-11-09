//
//  CSubscriber.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//

import Foundation
import Combine

class CSubscriber : Subscriber {
    typealias Input = Int
    typealias Failure = Error
    
    // 已成功订阅通知
    func receive(subscription: Subscription) {
        debugPrint("CSubscriber","receive1")
        subscription.request(Subscribers.Demand.unlimited)
    }
    
    // 接收到发布者发送的信息,返回值告诉发布者还希望接收的消息个数
    func receive(_ input: Int) -> Subscribers.Demand {
        debugPrint("CSubscriber","receive2")
        return Subscribers.Demand.none
    }
    
    // 发布者发布完成，可能成功，或失败
    func receive(completion: Subscribers.Completion<Failure>) {
        debugPrint("CSubscriber","receive3")
    }
}
