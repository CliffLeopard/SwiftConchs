//
//  OperatorCasesView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/13.
//

import SwiftUI

struct OperatorCasesView: View {
    var body: some View {
        VStack {
            createCase(tittle: "Sink") {
                CaseSink.case1()
            }
        }
    }
    
    func createCase(tittle:String, _ action:@escaping ()->Void) -> some View {
        Button(action: action) {
            Text(tittle)
        }
    }
}

struct OperatorCasesView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorCasesView()
    }
}
