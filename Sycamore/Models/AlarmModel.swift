//
//  AlarmModel.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import Foundation
import SwiftData

@Model
class AlarmModel {
    @Attribute(.unique) var time: Date
    var days: [Date]
    var isEnabled: Bool
    
    init(time: Date, days: [Date], isEnabled: Bool) {
        self.time = time
        self.days = days
        self.isEnabled = isEnabled
    }
}
