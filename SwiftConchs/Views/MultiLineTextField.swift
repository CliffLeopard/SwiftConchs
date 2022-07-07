//
//  MultiLineTextField.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/30.
//

import SwiftUI

struct MultiLineTextField: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return MultiLineTextField.Coordinator(self)
    }
    
    @Binding var text:String
    
    func makeUIView(context: Context) -> UITextView {
        let tView = UITextView()
        tView.isEditable = true
        tView.isUserInteractionEnabled = true
        tView.isScrollEnabled = true
        tView.delegate = context.coordinator
        tView.returnKeyType = .send
        return tView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTextField>) {
        
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent:MultiLineTextField
        
        init(_ p:MultiLineTextField) {
            self.parent = p
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .label
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            
            return true
        }
    }
}

//struct MultiLineTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiLineTextField()
//    }
//}
