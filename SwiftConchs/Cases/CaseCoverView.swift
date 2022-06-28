//
//  CaseCoverView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct CaseCoverView: View {
    @State var showPop = false
    var body: some View {
        Button("选择照片"){
            self.showPop = true
        }.customcover(self.$showPop) {
            VStack{
                Spacer()
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0){
                        Button(action: {
                            debugPrint("Click Shoot")
                        }, label: {
                            Text("Shoot").frame(width: 328, height: 55, alignment: .center)
                        })
                        
                        Rectangle().frame(width: 328, height: 1, alignment: .center).foregroundColor(Color.gray.opacity(0.4))
                        
                        Button(action: {
                            debugPrint("Click Photos")
                        }, label: {
                            Text("Photos").frame(width: 328, height: 55, alignment: .center)
                        })
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    
                    Button("Cancel") {
                        debugPrint("Click Cancel")
                    }
                    .frame(width: 328, height: 55, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.top, 8)
                }
                .font(.body)
            }
        }
    }
}

struct CaseCoverView_Previews: PreviewProvider {
    static var previews: some View {
        CaseCoverView()
    }
}
