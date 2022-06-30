//
//  CasePopover.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct CasePopMenuInScrolView: View {
    let cases = [
        "ASDSADSIIIJNNBBGGTYYUJJK","ASDSADSIIIJNNBBGGTYYU","ASDSFFD","MEDFFF","QAWEIROCJM",
        "QWONCNKSM","kk","kkkkk","pkjjjjjn","lllll",
        "llkjjjjjjj","kkkkk","LLL","LLLL","JKKKKKKKIKNNGFFFGHHNNNNNNNN"]
    @State var popId:String? = nil
    
    var body: some View {
        ScrollView {
            ForEach(0..<40) { key in
                let index = key % 15
                VStack{
                    HStack(alignment: .top){
                        Spacer()
                        Text(cases[index])
                            .popover(self.$popId,id: String(key), width: 180, height: 40, color: .purple) {
                                HStack{
                                    Text("删除")
                                    Divider()
                                    Text("撤回")
                                    Divider()
                                    Text("复制")
                                }.onTapGesture {
                                    self.popId = nil
                                }
                            }.onLongPressGesture {
                                self.popId = String(key)
                            }
                    }.environment(\.layoutDirection,  index % 2 == 0 ? .leftToRight : .rightToLeft)
                }
            }.padding()
        }
        .simultaneousGesture(
            TapGesture().onEnded {
                self.popId = nil
            }
        )
        .onDisappear{
            self.popId = nil
        }
    }
}

struct CasePopMenu_Previews: PreviewProvider {
    static var previews: some View {
        CasePopMenuInScrolView()
    }
}
