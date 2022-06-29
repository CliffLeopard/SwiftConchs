//
//  CaseUIKitPopMenu.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/28.
//

import SwiftUI

struct CaseUIKitPopMenu: View {
    let cases = ["ASDSADSIIIJNNBBGGTYYUJJK","ASAS","ASDSFFD","MEDFFF","QAWEIROCJM","QWONCNKSM","kk","kkkkk","pkjjjjjn","lllll","llkjjjjjjj","kkkkk"]
    @State var popId:String? = nil
    var body: some View {
        List {
            ForEach(0..<11) { index in
                VStack{
                    HStack(alignment: .top){
                        Spacer()
                        Text(cases[index])
                            .popMenu(self.$popId,id:String(index), width: 180, height: 40, color: .purple) {
                                HStack{
                                    Text("删除")
                                    Divider().background(Color.gray)
                                    Text("撤回")
                                    Divider().background(Color.gray)
                                    Text("编辑")
                                }
                            }.onLongPressGesture {
                                self.popId = String(index)
                            }
                    }.environment(\.layoutDirection,  index % 2 == 0 ? .leftToRight : .rightToLeft)
                }
            }
        }
        .onDisappear {
            debugPrint("Disappear")
            self.popId = nil
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                self.popId = nil
            }
        )
    }
}

struct CaseUIKitPopMenu_Previews: PreviewProvider {
    static var previews: some View {
        CaseUIKitPopMenu()
    }
}
