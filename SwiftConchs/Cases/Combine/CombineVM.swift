//
//  CombineVM.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//

import Foundation
import Combine
class CombineVM : ObservableObject{
    func multicast1() {
        let pub = ["First", "Second", "Third"].publisher
            .map( { return ($0, Int.random(in: 0...100)) } )
            .print("Random")
            .multicast { PassthroughSubject<(String, Int), Never>() }  //  一个发送者向多个订阅者发送不同的Subject
        sink(pub)
    }
    
    func multicast2() {
        let pub = ["First", "Second", "Third"].publisher
            .map( { return ($0, Int.random(in: 0...100)) } )
            .print("Random")
            .multicast(subject: PassthroughSubject<(String, Int), Never>())  // 一个发布者向多个订阅者发布同一个Subject
        sink(pub)
    }
    
    func publish() {
        let publisher = CPublisher()
        let subscriber = CSubscriber()
        publisher.subscribe(subscriber)
//        publisher.receive(subscriber: subscriber)
    }
    
    
    func caseSink() {
        let list = [1,2,3,4,5,6]
        let publisher = Publishers.Sequence<[Int],Never>(sequence: list)
        let subscriber = Subscribers.Sink<Int,Never> { completion in
            debugPrint("completion:",completion)
        } receiveValue: { value in
            debugPrint("receiveValue:",value)
        }
        
        let _ = publisher.subscribe(subscriber)
        
        let _ = publisher.sink { completion in
            debugPrint("subscription2","completion", completion)
        } receiveValue: { vaule in
            debugPrint("subscription2","value", vaule)
        }
        
        let _ = Array(0...6).publisher.sink { completion in
            debugPrint("subscription3","completion", completion)
        } receiveValue: { value in
            debugPrint("subscription3","completion", value)
        }
    }
    
    func caseSubject() {
        debugPrint("caseSubject")
        let subject = PassthroughSubject<String,ExampleError> ()
        var cancels = Set<AnyCancellable>()
        let _ = subject.sink { completion in
            debugPrint("caseSubject","completion",completion)
        } receiveValue: { value in
            debugPrint("caseSubject", "value",value)
        }.store(in: &cancels)
        
        subject.send("Hello")
        subject.send("Hello Again")
        subject.send(completion: .failure(.somethingWrong))
        subject.send("Hello Again Again")
        subject.send(completion: .finished)
    }
    
    enum ExampleError:Swift.Error {
        case somethingWrong
    }
    
    
    func sink<K,S,J>(_ pub: K) where K:Publishers.Multicast<J, S> ,S : Subject , J:Publisher, J.Failure == S.Failure, J.Output == S.Output, K.Failure == Never{
        let _ = pub
            .sink { print ("Stream 1 received: \($0)")}
        let _ = pub
            .sink { print ("Stream 2 received: \($0)")}
        let _ = pub.connect()
    }
    
}
