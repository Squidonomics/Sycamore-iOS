//
//  Item.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
