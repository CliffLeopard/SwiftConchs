//
//  CaseCombineView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/12.
//

import SwiftUI

struct CaseCombineView: View {
    @StateObject var vm = CombineVM()
    var body: some View {
        VStack {
            
            Group {
                Button(action: {
                    vm.multicast1()
                }, label: {
                    Text("多播1")
                })
                
                Button(action: {
                    vm .multicast2()
                }, label: {
                    Text("多播2")
                })
                
                Button(action: {
                    vm.publish()
                }, label: {
                    Text("Publish")
                })
                
                Button(action: {
                    vm.caseSink()
                }, label: {
                    Text("Case")
                })
                
                Button(action: {
                    vm.caseSubject()
                }, label: {
                    Text("Subject")
                })
            }
            NavigationLink("OperatorCaseView") {
                OperatorCasesView()
            }
        }
        
    }
}

struct CaseCombineView_Previews: PreviewProvider {
    static var previews: some View {
        CaseCombineView()
    }
}
