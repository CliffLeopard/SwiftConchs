//
//  AsyncFucView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/8.
//

import SwiftUI

struct AsyncFucView: View {
    @State var state1:TaskState = .notwork
    @State var state2:TaskState = .notwork
    @State var state3:TaskState = .notwork
    
    var body: some View {
        VStack {
            Button {
                debugPrint("task-main",Thread.current)
                Task {
                    await task30()
                }
            } label: {
                Text("ClickMeDoTasks1")
            }
            
            Button {
                debugPrint("task-main",Thread.current)
                Task {
                    await task31()
                }
            } label: {
                Text("ClickMeDoTasks2")
            }
            
            Button {
                debugPrint("task-main",Thread.current)
                Task {
                    async let before3:() =  await withTaskGroup(of: Void.self, body: { group in
                        debugPrint("in Group", Thread.current)
                        group.addTask {
                            await task1()
                        }
                        
                        group.addTask {
                            await task2()
                        }
                    })
                    state3 = .waiting
                    await before3
                    await task3()
                    
                }
            } label: {
                Text("ClickMeDoTasks3")
            }
            
            
            stateView(1,state: self.state1)
            stateView(2,state: self.state2)
            stateView(3,state: self.state3)
            
            Button {
                state1 = .notwork
                state2 = .notwork
                state3 = .notwork
            } label: {
                Text("Clear")
            }
        }
    }
    
    
    func task1() async {
        state1 = .woring
        debugPrint("task1",Thread.current)
        sleep(3)
        state1 = .complet
    }
    
    func task2()  async {
        state2 = .woring
        debugPrint("task2",Thread.current)
        sleep(1)
        state2 = .complet
    }
    
    func task3() async {
        state3 = .woring
        debugPrint("task3",Thread.current)
        sleep(3)
        state3 = .complet
    }
    
    
    // 错误使用，串行执行。 task1 ,tasks ,task3
    func task30() async {
        state3 = .waiting
        await task1()
        await task2()
        
        state3 = .woring
        debugPrint("task3",Thread.current)
        sleep(5)
        state3 = .complet
        
    }
    
    // task1, task2 并行执行，其结果和task3串行执行
    func task31() async {
        state3 = .waiting
        // async let 异步绑定
        async let t1: () = task1()
        async let t2: () = task2()
        
        await t1
        await t2
        state3 = .woring
        debugPrint("task3",Thread.current)
        sleep(2)
        state3 = .complet
        
    }
    
    @ViewBuilder
    func stateView(_ number:Int, state:TaskState) -> some View {
        HStack{
            Text("Task\(number):")
            Text("\(state.rawValue)")
                .foregroundColor(state.color())
        }
    }
}

struct AsyncFucView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncFucView()
    }
}
