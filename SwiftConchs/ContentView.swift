//
//  ContentView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var showpop = false
    let viewCases: [CaseLink] = [
        CaseLink("CasePopMenuInScrolView", CasePopMenuInScrolView()),
        CaseLink("CasePopMenuInList", CasePopMenuInList()),
        CaseLink("CaseMenu", CaseMenu()),
        CaseLink("CaseCoverView", CaseCoverView()),
        CaseLink("CaseMultiGesture", CaseMultiGesture()),
        CaseLink("CaseTextField", CaseTextField()),
        CaseLink("CaseSafeArea", CaseSafeArea()),
        CaseLink("CaseListBgView", CaseListBgView()),
        CaseLink("MagifierGlassVuew",MagnifierExampleView())
    ]
    
    let asyncCases:[CaseLink] = [
        CaseLink("DispatchQueue",DispatchQueueView()),
        CaseLink("AsyncFuc", AsyncFucView()),
        CaseLink("LetWait",LetWaitView()),
        CaseLink("TaskGroup",TaskGroupView())
    ]
    
    let pCases:[CaseLink] = [
        CaseLink("StateProperty",CasePropertyWrapperView())
    ]
    
    let cCases:[CaseLink] = [
        CaseLink("CombineView",CaseCombineView())
    ]
    
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    Section("Views") {
                        ForEach(viewCases) { caseItem in
                            NavigationLink(caseItem.label) {
                                caseItem.view
                            }
                        }
                    }
                    
                    Section("Async") {
                        ForEach(asyncCases) { caseItem in
                            NavigationLink(caseItem.label) {
                                caseItem.view
                            }
                        }
                    }
                    
                    Section("Property") {
                        ForEach(pCases) { caseItem in
                            NavigationLink(caseItem.label) {
                                caseItem.view
                            }
                        }
                    }
                    
                    Section("Combine") {
                        ForEach(cCases) { caseItem in
                            NavigationLink(caseItem.label) {
                                caseItem.view
                            }
                        }
                    }
                }
                Spacer()
            }.navigationTitle("SwiftConchs")
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
