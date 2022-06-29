//
//  PopMenuKeyTypes.swift
//  SwiftConchs
//
//  Created by CliffLeopard on 2022/6/28.
//

import Foundation
import SwiftUI

struct PopMenuKeyTypes {
    struct PrefData: Equatable {
        var arrowDown:  Bool
        var originRect: CGRect?
        var popSize:    CGSize?
    }
    
    struct PrefKey: PreferenceKey {
        static var defaultValue = PrefData(arrowDown: false, originRect: nil, popSize: nil)
        static func reduce(value: inout PrefData, nextValue: () -> PrefData) {
            var newVaule =  value
            newVaule.arrowDown = nextValue().arrowDown
            if let rect  = nextValue().originRect {
                newVaule.originRect = rect
            }
            
            if let size = nextValue().popSize {
                newVaule.popSize = size
            }
            value = newVaule
        }
        typealias Value = PrefData
    }
}
