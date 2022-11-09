//
//  CaseListBgView2.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/6.
//

import SwiftUI

struct CaseListBgView2: View {
    var body: some View {
        VStack {
            List {
                ForEach(0..<4) { index in
                    Text("List1 Text\(index)")
                        .listRowBackground( LinearGradient(gradient: Gradient(colors: [Color.green, Color.green.opacity(0.50)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .listRowSeparator(.hidden)
                }
            }
//            .background(Color.red)
            
            List{
                Text("List2 Text1")
                    .listRowBackground(Color.purple)
                Text("List2 Text2")
                    .listRowSeparator(.hidden)
                Text("List2 Text3")
                    .listSectionSeparator(.hidden)
                Text("List2 Text4")
                Text("List2 Text5")
            }
        }.onAppear{
//            UITableView.appearance().backgroundColor = UIColor.red
//            UITableViewCell.appearance().contentView.backgroundColor = UIColor.orange
//            UITableViewCell.appearance().selectedBackgroundView = UIView()
        }
    }
}

struct CaseListBgView2_Previews: PreviewProvider {
    static var previews: some View {
        CaseListBgView2()
    }
}
