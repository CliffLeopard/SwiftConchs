//
//  CaseTextField.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/30.
//

import SwiftUI

struct CaseTextField: View {
    @State private var profileText = ""
    @State private var firstname: String = ""
    @State private var secondName: String = ""
    @State private var invalid: Bool = false
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Text("TextEditor输入信息:")
                TextEditor(text: $profileText)
                             .foregroundColor(.secondary)
                             .padding(.horizontal)
                             .frame(height: 40, alignment: .center)
                             .border(Color.gray, width: 2)
                             .cornerRadius(3)
                             .submitLabel(.send)
            }
            
            HStack{
                Text("TextField输入信息:")
                TextField("Firstname",text: $firstname)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .submitLabel(.send)
            }
            
            HStack {
                Text("封装UIText:")
                MultiLineTextField(text: $secondName)
                    .submitLabel(.send)
                    .frame(height: 35, alignment: .center)
                    .border(Color.gray, width: 2)
                    .font(.largeTitle)
            }

        }
    }
    
    func validate() {
          if self.firstname == ""  {
              self.invalid = true
          }
      }
}

struct CaseTextField_Previews: PreviewProvider {
    static var previews: some View {
        CaseTextField()
    }
}
