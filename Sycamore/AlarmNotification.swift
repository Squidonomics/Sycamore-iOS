//
//  AlarmNotification.swift
//  Sycamore
//
//  Created by Brian on 1/4/24.
//

import Foundation
import UserNotifications



public func sendAlarmNotification(timeToSend: Date, dayToSend: String?, timeZone: String, uuid: String) {
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter
        }()
    let content = UNMutableNotificationContent()
    content.title = "Alarm"
    content.body = "Your alarm for \(dateFormatter.string(from: timeToSend))"
    content.sound = UNNotificationSound.defaultRingtone
    
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
    
    switch dayToSend {
    case "Sunday":
        dateComponents.weekday = 1
    case "Monday":
        dateComponents.weekday = 2
    case "Tuesday":
        dateComponents.weekday = 3
    case "Wednesday":
        dateComponents.weekday = 4
    case "Thursday":
        dateComponents.weekday = 5
    case "Friday":
        dateComponents.weekday = 6
    case "Saturday":
        dateComponents.weekday = 7
    case .none:
        print("There is no date selected")
    case .some(_):
        print("Some dates selected")
    }
    
    dateComponents.hour = hourInt
    dateComponents.minute = minuteInt
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { (error) in
       if error != nil {
           print(error ?? "There was an error sending the notification")
       }
    }
}
