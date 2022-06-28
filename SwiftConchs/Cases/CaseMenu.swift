//
//  CaseMenu.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/28.
//

import SwiftUI

struct CaseMenu: View {
    let cases = ["ASAS","ASDSFFD","MEDFFF","QAWEIROCJM","QWONCNKSM"]
    let menus = [
        EditMenuItem("menu1", action: {
            debugPrint("Menu1")
        }),
        EditMenuItem("menu2", action: {
            debugPrint("Menu2")
        })
    ]
    var body: some View {
        LazyVStack{
            ForEach(cases,id:\.hashValue) { item in
                Text(item)
                    .editMenu {
                        menus
                    }
                Spacer()
            }
        }
    }
}

struct CaseMenu_Previews: PreviewProvider {
    static var previews: some View {
        CaseMenu()
    }
}
