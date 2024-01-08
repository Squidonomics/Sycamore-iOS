//
//  AlarmComponents.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import Foundation
import SwiftUI
import SwiftData

struct AlarmListItem: View {
    @State private var isExapanded: Bool = false
    @State var alarmIsOn: Bool
    @State var setAlarmTime: Date
    @State var daysToSound: [Days]
    @State var timeZone: String
    @State var notificationUUID: String
    @StateObject private var viewModel = alarmNotificationRemove()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    var body: some View {
        VStack{
            HStack{
                VStack {
                    HStack {
                        Text(dateFormatter.string(from: $setAlarmTime.wrappedValue))
                            .font(.title.bold())
                        Button(action: {isExapanded.toggle(); print(daysToSound)}){
                            Image(systemName: "arrowshape.down.circle.fill")
                        }
                    }
                    Text($timeZone.wrappedValue)
                        .font(.subheadline)
                        .lineLimit(1)
                        .frame(width: 200)
                }
                Toggle("", isOn: $alarmIsOn)
                    .onChange(of: alarmIsOn) {
                        if(!alarmIsOn) {
                            print("Alarm removed")
                            let center = UNUserNotificationCenter.current()
                            center.removePendingNotificationRequests(withIdentifiers: [$notificationUUID.wrappedValue])
                        } else {
                            for day in daysToSound {
                                sendAlarmNotification(timeToSend: setAlarmTime, dayToSend: day.rawValue, timeZone: timeZone, uuid: notificationUUID)
                            }
                        }
                    }
                if(isExapanded == true){
                    DayOfTheWeek(selectedDays: $daysToSound)
                }
            }
            .padding(
                EdgeInsets(
                    top: 25,
                    leading: 5,
                    bottom: 25,
                    trailing: 5
                )
            )
        }
    }
}


struct AlarmForm: View {
    @State private var selectedTime: Date = Date.now
    @Query(sort: \AlarmModel.time) var alarms: [AlarmModel]
    @Environment(\.modelContext) private var modelContext
    @State var selectedDay: [Days] = []
    @State var timeZone: TimeZones = .EST
    @State var uuid: String = ""
    @Binding var addAlarmBool: Bool
    var body: some View {
        Form {
            DatePicker("Set Alarm Time",selection: $selectedTime, displayedComponents: .hourAndMinute)
            DayOfTheWeek(selectedDays: $selectedDay)
            Picker("Time zone", selection: $timeZone) {
                Text("Pacific Standard Time").tag(TimeZones.PST)
                Text("Eastern Standard Time").tag(TimeZones.EST)
                Text("Central Standard Time").tag(TimeZones.CST)
                Text("Mountain Standard Time").tag(TimeZones.MDT)
            }
            Button(action: {addAlarm(); addAlarmBool = false;
                for day in selectedDay {
                    sendAlarmNotification(timeToSend: selectedTime, dayToSend: day.rawValue, timeZone: timeZone.rawValue, uuid: String("\(selectedTime)\(timeZone.rawValue)"))
                }}) {
                Text("Add Alarm")
            }
        }
    }
    
    private func addAlarm() {
        withAnimation {
            let newAlarm = AlarmModel(time: selectedTime, days: selectedDay, isEnabled: true, timeZone: String(timeZone.rawValue), notificationUUID: String("\(selectedTime)\(timeZone.rawValue)"))
            modelContext.insert(newAlarm)
            modelContext.autosaveEnabled = true
        }
    }
}
    

struct DayOfTheWeek: View {
    @Binding var selectedDays: [Days]
    var body: some View {
        HStack{
            ForEach(Days.allCases, id: \.self) { day in
                Text(String(day.rawValue.first!))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(selectedDays.contains(day) ? Color.cyan.cornerRadius(10) : Color.gray.cornerRadius(10))
                    .onTapGesture {
                        if selectedDays.contains(day) {
                            selectedDays.removeAll(where: {$0 == day})
                        } else {
                            selectedDays.append(day)
                        }
                    }
            }
        }
    }
}

class alarmNotificationRemove: ObservableObject {
    func removePendingAlarms(uuid: String) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [uuid])
    }
}
