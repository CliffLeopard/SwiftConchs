//
//  Publishers++.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//

import Foundation
import Combine
import UIKit
extension Publishers {
    private final class UIControlSubscription<S:Subscriber,Control:UIControl>:Subscription where S.Input == Control, S.Failure == Never {
        private var subscriber:S?
        private let control:Control
        private let event:Control.Event
        
        init(subscriber:S, control:Control, event:Control.Event) {
            self.subscriber = subscriber
            self.control = control
            self.event = event
        }
        
        deinit {
            debugPrint("---- UIControlSubscription deinit")
        }
        
        func request(_ demand:Subscribers.Demand) {
            debugPrint("request")
        }

        
        func cancel() {
            self.subscriber = nil
            debugPrint("cancel")
        }
        
        private func subscribe() {
            self.control.addTarget(self, action: #selector(self.eventHandler), for: self.event)
        }
        
        @objc private func eventHandler() {
            _ = subscriber?.receive(self.control)
        }
    }
}

extension Publishers {
    struct UIControllerPublisher<Control:UIControl>:Publisher {
        typealias Output = Control
        typealias Failure = Never
        
        let control:Control
        let controlEvent:UIControl.Event
        
        init(control:Control, controlEvent:UIControl.Event) {
            self.control = control
            self.controlEvent = controlEvent
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Control == S.Input {
            let subscription = UIControlSubscription(subscriber: subscriber, control: self.control, event: self.controlEvent)
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIControl {
    func publisher(for events:UIControl.Event) -> Publishers.UIControllerPublisher<UIControl> {
        return Publishers.UIControllerPublisher(control: self, controlEvent: events)
    }
}

extension UITextField {
    func publisherForTextChanged() {
        Publishers.UIControllerPublisher(control: self, controlEvent: .editingChanged)
            .map{$0.text}
            .eraseToAnyPublisher()
    }
}

extension UISwitch {
    func publisher() -> AnyPublisher<Bool,Never>{
        return Publishers.UIControllerPublisher(control: self, controlEvent: .valueChanged)
            .map{$0.isOn}
            .eraseToAnyPublisher()
    }
}

extension UISlider {
    func publisher()  -> AnyPublisher<Float,Never> {
        return Publishers.UIControllerPublisher(control: self, controlEvent: .valueChanged)
            .map{ $0.value }
            .eraseToAnyPublisher()
    }
}
