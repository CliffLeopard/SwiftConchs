//
//  ShapeExampleView.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/11/9.
//

import SwiftUI

struct ShapeExampleView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            sampleViews("Without Material")

            sampleViews("Regular Material")
                .background(.regularMaterial)
        }
    }
    
    func sampleViews(_ name: String) -> some View {
        HStack {
            CustomView(role: .stroke)
            CustomView(role: .fill)
            CustomView(role: .separator)
            
            Spacer()
            
            Text(name)
            
            Spacer()
        }
        .frame(width: 350)
        .padding(.vertical, 10)
        .padding(.leading, 20)
        .border(.secondary)
    }

    struct CustomView: View {
        let role: ShapeRole
        
        var body: some View {
            ZStack {
                LinearGradient(colors: [Color.orange, Color.green],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                
                Group {
                    switch role {
                        case .fill:
                            CircleWithFillRole()
                        case .stroke:
                            CircleWithStrokeRole()
                        case .separator:
                            CircleWithSeparatorRole()
                        @unknown default:
                            fatalError()
                    }
                }
                .padding(10)
            }
            .frame(width: 50, height: 50)
        }
        
        struct CircleWithSeparatorRole: Shape {
            static var role: ShapeRole { .separator }
            
            func path(in rect: CGRect) -> Path {
                Circle().path(in: rect)
            }
        }
        
        struct CircleWithFillRole: Shape {
            static var role: ShapeRole { .fill }
            
            func path(in rect: CGRect) -> Path {
                Circle().path(in: rect)
            }
        }
        
        struct CircleWithStrokeRole: Shape {
            static var role: ShapeRole { .stroke }
            
            func path(in rect: CGRect) -> Path {
                Circle().path(in: rect)
            }
        }
    }
}



struct ShapeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeExampleView()
    }
}
