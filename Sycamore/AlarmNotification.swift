//
//  AlarmNotification.swift
//  Sycamore
//
//  Created by Brian on 1/4/24.
//

import Foundation
import UserNotifications


public func sendAlarmNotification(timeToSend: Date, dayToSend: Int?, timeZone: String) {
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter
        }()
    let content = UNMutableNotificationContent()
    content.title = "Alarm"
    content.body = "Your alarm for \(dateFormatter.string(from: timeToSend))"
    
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
    let hourFormatter = DateFormatter()
    hourFormatter.dateFormat = "HH"
    let hourInt = Int(hourFormatter.string(from: timeToSend))
    
    let minuteFormatter = DateFormatter()
    minuteFormatter.dateFormat = "mm"
    let minuteInt = Int(minuteFormatter.string(from: timeToSend))
    
    switch timeZone {
    case "Pacific Standard Time":
        let timeZoneIndentifier = TimeZone(identifier: "America/Los_Angeles")
        dateComponents.timeZone = timeZoneIndentifier
    case "Eastern Standard Time":
        let timeZoneIndentifier = TimeZone(identifier: "America/New_York")
        dateComponents.timeZone = timeZoneIndentifier
    case "Central Standard Time":
        let timeZoneIndentifier = TimeZone(identifier: "America/Chicago")
        dateComponents.timeZone = timeZoneIndentifier
    case "Mountain Standard Time":
        let timeZoneIndentifier = TimeZone(identifier: "America/Denver")
        dateComponents.timeZone = timeZoneIndentifier
    default:
        let timeZoneIndentifier = TimeZone(identifier: "America/New_York")
        dateComponents.timeZone = timeZoneIndentifier
    }
    
    dateComponents.weekday = dayToSend ?? 1
    dateComponents.hour = hourInt
    dateComponents.minute = minuteInt
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { (error) in
       if error != nil {
           print(error ?? "There was an error sending the notification")
       }
    }
}
