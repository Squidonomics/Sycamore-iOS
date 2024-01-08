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
    var timeZone: String
    var notificationUUID: String
    
    init(time: Date, days: [Days], isEnabled: Bool, timeZone: String, notificationUUID: String) {
        self.time = time
        self.days = days
        self.isEnabled = isEnabled
        self.timeZone = timeZone
        self.notificationUUID = notificationUUID
    }
}

public enum Days: String, CaseIterable, Codable {
    case Sunday,
         Monday,
         Tuesday,
         Wednesday,
         Thursday,
         Friday,
         Saturday
}

//public enum Days: Int, CaseIterable, Codable {
//    case Sunday = 1,
//         Monday = 2,
//         Tuesday = 3,
//         Wednesday = 4,
//         Thursday = 5,
//         Friday = 6,
//         Saturday = 7
//}

public enum TimeZones: String, CaseIterable, Codable {
    case PST = "Pacific Standard Time",
         EST = "Eastern Standard Time",
         MDT = "Mountain Standard Time",
         CST = "Central Standard Time"
}
