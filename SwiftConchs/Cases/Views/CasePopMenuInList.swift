//
//  CaseUIKitPopMenu.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/28.
//

import SwiftUI

struct CasePopMenuInList: View {
    let cases = [
        "ASDSADSIIIJNNBBGGTYYUJJK","ASDSADSIIIJNNBBGGTYYU","ASDSFFD","MEDFFF","QAWEIROCJM",
        "QWONCNKSM","kk","kkkkk","pkjjjjjn","lllll",
        "llkjjjjjjj","kkkkk","LLL","LLLL","JKKKKKKKIKNNGFFFGHHNNNNNNNN"]
    @State var popId:String? = nil
    var body: some View {
        List {
            ForEach(0..<15) { index in
                VStack{
                    HStack(alignment: .top){
                        Spacer()
                        Text(cases[index])
                            .popMenu(self.$popId,id:String(index), width: 200, height: 40, color: .purple) {
                                HStack{
                                    Text("删除").foregroundColor(Color.white)
                                        .onTapGesture {
                                            debugPrint("Delete")
                                        }
                                    Divider().background(Color.gray)
                                    Text("撤回").foregroundColor(Color.white)
                                    Divider().background(Color.gray)
                                    Text("编辑").foregroundColor(Color.white)
                                }
                            }
                            .onLongPressGesture {
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

struct CasePopMenuInList_Previews: PreviewProvider {
    static var previews: some View {
        CasePopMenuInList()
    }
}
