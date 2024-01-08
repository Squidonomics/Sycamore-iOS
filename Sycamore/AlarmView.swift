//
//  AlarmView.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import SwiftUI
import SwiftData

struct AlarmView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \AlarmModel.time) var alarms: [AlarmModel]
    let backgrounds = [
        Color(teaGreen),
        Color(beige),
        Color(cornSilk),
        Color(papayaWhip),
        Color(buff)
    ]
    @State var addAlarm: Bool = false
    var body: some View {
        HStack {
            Spacer()
            Button(action: { addAlarm = true }) {
                Image(systemName: "plus")
                    .padding(.horizontal)
            }
        }
        List {
            ForEach(alarms) { alarm in
                AlarmListItem(alarmIsOn: alarm.isEnabled, setAlarmTime: alarm.time, daysToSound: alarm.days, timeZone: alarm.timeZone, notificationUUID: alarm.notificationUUID)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .background(.clear)
                            .foregroundColor(backgrounds.randomElement())
                            .padding(
                                EdgeInsets(
                                    top: 2,
                                    leading: 10,
                                    bottom: 2,
                                    trailing: 10
                                )
                            )
                    )
            }
            .onDelete(perform: deleteAlarms)
        }
        .listStyle(.plain)
        .sheet(isPresented: $addAlarm, content: {
            AlarmForm(addAlarmBool: $addAlarm)
        })
    }
    
    private func deleteAlarms(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(alarms[index])
            }
        }
    }
}

