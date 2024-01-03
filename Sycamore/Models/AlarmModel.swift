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
    var days: [Days]
    var isEnabled: Bool
    
    init(time: Date, days: [Days], isEnabled: Bool) {
        self.time = time
        self.days = days
        self.isEnabled = isEnabled
    }
}

enum Days: String, CaseIterable, Codable {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}
