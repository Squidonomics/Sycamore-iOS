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
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        Button(action: addAlarm) {
            Label("Add Alarm", systemImage: "plus")
        }
        List(alarms) { alarm in
            AlarmListItem(alarmIsOn: alarm.isEnabled, setAlarmTime: alarm.time.description)
        }
    }
    
    private func addAlarm() {
        withAnimation {
            let newAlarm = AlarmModel(time: Date.now, days: [Date.now], isEnabled: true)
            modelContext.insert(newAlarm)
            modelContext.autosaveEnabled = true
        }
    }
}

