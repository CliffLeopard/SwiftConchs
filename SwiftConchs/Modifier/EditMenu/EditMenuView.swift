//
//  EditMenuView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI
import UIKit

public struct EditMenuItem {
    public let title: String
    public let action: () -> Void
    
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

public extension View {
    /// Attaches a long-press action to this `View` withe the given item titles & actions
    func editMenu(@ArrayBuilder<EditMenuItem> _ items: () -> [EditMenuItem]) -> some View {
        EditMenuView(content: self, items: items())
            .fixedSize()
    }
}

public struct EditMenuView<Content: View>: UIViewControllerRepresentable {
    public typealias Item = EditMenuItem
    
    public let content: Content
    public let items: [Item]
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(items: items)
    }
    
    public func makeUIViewController(context: Context) -> UIHostingController<Content> {
        let coordinator = context.coordinator
        let hostVC = HostingController(rootView: content) { [weak coordinator] index in
            guard let items = coordinator?.items else { return }
            if !items.indices.contains(index) {
                assertionFailure()
                return
            }
            items[index].action()
        }
        coordinator.responder = hostVC
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.longPress))
        hostVC.view.addGestureRecognizer(longPress)
        
        return hostVC
    }
    
    public func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        
    }
    
    public class Coordinator: NSObject {
        let items: [Item]
        var responder: UIResponder?
        
        init(items: [Item]) {
            self.items = items
        }
        
        @objc func longPress(_ gesture: UILongPressGestureRecognizer) {
            let menu = UIMenuController.shared
            
            guard gesture.state == .began, let view = gesture.view, !menu.isMenuVisible else {
                return
            }
            responder?.becomeFirstResponder()
            menu.menuItems = items.enumerated().map { index, item in
                UIMenuItem(title: item.title, action: IndexedCallable.selector(for: index))
            }
            menu.showMenu(from: view, rect: view.bounds)
        }
    }
    
    class HostingController<Content: View>: UIHostingController<Content> {
        private var callable: IndexedCallable?
        
        convenience init(rootView: Content, handler: @escaping (Int) -> Void) {
            self.init(rootView: rootView)
            preferredContentSize = view.intrinsicContentSize
            callable = IndexedCallable(handler: handler)
        }
        
        override var canBecomeFirstResponder: Bool {
            true
        }
        
        override func responds(to aSelector: Selector!) -> Bool {
            return super.responds(to: aSelector) || IndexedCallable.willRespond(to: aSelector)
        }
        
        override func forwardingTarget(for aSelector: Selector!) -> Any? {
            guard IndexedCallable.willRespond(to: aSelector) else {
                return super.forwardingTarget(for: aSelector)
            }
            
            return callable
        }
    }
}
