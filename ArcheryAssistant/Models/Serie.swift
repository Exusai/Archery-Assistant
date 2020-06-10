//
//  Serie.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 14/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import Foundation

struct Serie: Codable {
    var Arrows: [Arrow] = []
    var sum: Int {
        var sum: Int = 0
        for arrow in self.Arrows {
            sum += arrow.value
        }
        return sum
    }
    var sumX: Int {
        var sumX: Int = 0
        for arrow in self.Arrows{
            if arrow.isX {
                sumX += 1
            }
        }
        return sumX
    }
    var sum10: Int {
        var sum10: Int = 0
        for arrow in self.Arrows {
            if arrow.value == 10 {
                sum10 += 1
            }
        }
        return sum10
    }
    
    mutating func orderArrows(){
        self.Arrows = self.Arrows.sorted(by: { ($0.isX && !$1.isX) })
        self.Arrows = self.Arrows.sorted(by: >)
    }
}
