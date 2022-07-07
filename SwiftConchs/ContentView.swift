//
//  ContentView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var showpop = false
    let cases: [CaseLink] = [
        CaseLink("CasePopMenuInScrolView", CasePopMenuInScrolView()),
        CaseLink("CasePopMenuInList", CasePopMenuInList()),
        CaseLink("CaseMenu", CaseMenu()),
        CaseLink("CaseCoverView", CaseCoverView()),
        CaseLink("CaseMultiGesture", CaseMultiGesture()),
        CaseLink("CaseTextField", CaseTextField()),
        CaseLink("CaseSafeArea", CaseSafeArea()),
        CaseLink("CaseListBgView", CaseListBgView())
    ]
    var body: some View {
        NavigationView {
            LazyVStack{
                ForEach(cases) { caseItem in
                    NavigationLink(caseItem.label) {
                        caseItem.view
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CaseLink : Identifiable{
    let id = UUID()
    let label: LocalizedStringKey
    let view: AnyView
    
    init<V>(_ label: LocalizedStringKey, _ view: V)  where V:View{
        self.label = label
        self.view = AnyView(view)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
