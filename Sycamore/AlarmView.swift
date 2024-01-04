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
        AlarmForm()
        List(alarms) { alarm in
            AlarmListItem(alarmIsOn: alarm.isEnabled, setAlarmTime: alarm.time, daysToSound: alarm.days)
        }
    }
}

