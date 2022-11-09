//
//  CSubscription.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//

import Foundation
import Combine

class CSubscription : Subscription {
    func request(_ demand: Subscribers.Demand) {
        debugPrint("CSubscription","request")
    }
    
    func cancel() {
        debugPrint("CSubscription","cancel")
    }
    
}
