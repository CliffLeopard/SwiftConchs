//
//  CasePopover.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/24.
//

import SwiftUI

struct CasePopMenu: View {
    @State var showPop = false
    let cases = ["ASAS","ASDSFFD","MEDFFF","QAWEIROCJM","QWONCNKSM"]
    var body: some View {
        ScrollView {
            ForEach(cases,id:\.hashValue) { item in
                VStack{
                    HStack(alignment: .top){
                        Spacer()
                        Text("QAW")
                            .popover(self.$showPop, width: 180, height: 40, color: .purple) {
                                HStack{
                                    Text("删除")
                                    Divider()
                                    Text("撤回")
                                    Divider()
                                    Text("复制")
                                }.onTapGesture {
                                    self.showPop = false
                                }
                            }.onLongPressGesture {
                                self.showPop = true
                            }
                    }.padding()
                        .environment(\.layoutDirection,  .leftToRight)
                    
                    HStack(alignment: .top){
                        Spacer()
                        Text("QAW")
                            .popover(self.$showPop, width: 180, height: 40, color: .purple) {
                                HStack{
                                    Text("删除")
                                    Divider()
                                    Text("撤回")
                                    Divider()
                                    Text("复制")
                                }.onTapGesture {
                                    self.showPop = false
                                }
                            }.onLongPressGesture {
                                self.showPop = true
                            }
                    }.padding()
                        .environment(\.layoutDirection,  .rightToLeft)
                    
                    
                    
                    HStack(alignment: .top){
                        Spacer()
                        Text("QAWADDKSKDKDKLLKSDDD")
                            .popover(self.$showPop, width: 180, height: 40, color: .purple) {
                                HStack{
                                    Text("删除")
                                    Divider()
                                    Text("撤回")
                                    Divider()
                                    Text("复制")
                                }.onTapGesture {
                                    self.showPop = false
                                }
                            }.onLongPressGesture {
                                self.showPop = true
                            }
                    }.padding()
                        .environment(\.layoutDirection,  .leftToRight)
                    
                    
                    HStack(alignment: .top){
                        Spacer()
                        Text("QAWADDKSKDKDKLLKSDDDD")
                            .popover(self.$showPop, width: 180, height: 40, color: .purple) {
                                HStack{
                                    Text("删除")
                                    Divider()
                                    Text("撤回")
                                    Divider()
                                    Text("复制")
                                }.onTapGesture {
                                    self.showPop = false
                                }
                            }.onLongPressGesture {
                                self.showPop = true
                            }
                    }.padding()
                        .environment(\.layoutDirection,  .rightToLeft)
                }}
        }
    }
}

struct CasePopMenu_Previews: PreviewProvider {
    static var previews: some View {
        CasePopMenu()
    }
}
