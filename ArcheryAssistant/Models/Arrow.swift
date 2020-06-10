//
//  Arrow.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 14/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import Foundation

struct Arrow: Codable, Comparable {
    static func < (lhs: Arrow, rhs: Arrow) -> Bool {
        return lhs.value < rhs.value
    }
    
    var xCord: Double?
    var yCord: Double?
    
    var value: Int
    var isX: Bool
    var isM: Bool {
        if self.value == 0 {
            return true
        } else {
            return false
        }
    }
}
