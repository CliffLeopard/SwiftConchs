//
//  DispatchQueueView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/7/8.
//                 --> task1
//    startWork                 --> task3   --> complete
//                 --> task2

import SwiftUI

struct DispatchQueueView: View {
    @State var state1:TaskState = .notwork
    @State var state2:TaskState = .notwork
    @State var state3:TaskState = .notwork
    
    var body: some View {
        VStack {
            Button {
                startWork()
            } label: {
                Text("ClickMeDoTasks")
            }
            
            stateView(1,state: self.state1)
            stateView(2,state: self.state2)
            stateView(3,state: self.state3)
        }
    }
    
    func startWork() {
        task1()
        task2()
        task3()
    }
    
    func task1() {
        DispatchQueue.global().async {
            state1 = .woring
            debugPrint("task1",Thread.current)
            sleep(2)
            DispatchQueue.main.async {
                state1 = .complet
                if state3 == .waiting &&  state2 == .complet {
                    task3()
                }
            }
        }
    }
    
    func task2() {
        DispatchQueue.global().async {
            state2 = .woring
            debugPrint("task2",Thread.current)
            sleep(3)
            DispatchQueue.main.async {
                state2 = .complet
                if state3 == .waiting &&  state1 == .complet {
                    task3()
                }
            }
        }
    }
    
    func task3() {
        DispatchQueue.global().async {
            if state1 != .complet || state2 != .complet {
                state3 = .waiting
            } else {
                state3 = .woring
                debugPrint("task3",Thread.current)
                sleep(2)
                DispatchQueue.main.async {
                    state3 = .complet
                }
            }
        }
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

struct DispatchQueueView_Previews: PreviewProvider {
    static var previews: some View {
        DispatchQueueView()
    }
}
