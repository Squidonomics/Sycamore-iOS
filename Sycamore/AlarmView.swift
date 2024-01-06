//
//  AlarmView.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import SwiftUI
import SwiftData

struct AlarmView: View {
    @Query(sort: \AlarmModel.time) var alarms: [AlarmModel]
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        AlarmForm()
        List(alarms) { alarm in
            AlarmListItem(alarmIsOn: alarm.isEnabled, setAlarmTime: alarm.time, daysToSound: alarm.days)
        }
    }
}

