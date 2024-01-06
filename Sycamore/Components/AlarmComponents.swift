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
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter
        }()
    var body: some View {
        VStack{
            HStack{
                Text(dateFormatter.string(from: $setAlarmTime.wrappedValue))
                    .font(.title.bold())
                Button(action: {isExapanded.toggle(); print(daysToSound)}){
                    Image(systemName: "arrowshape.down.circle.fill")
                }
                Toggle("", isOn: $alarmIsOn)
            }
            if(isExapanded == true){
                DayOfTheWeek(selectedDays: $daysToSound)
            }
        }
        .padding()
    }
}

struct AlarmForm: View {
    @State private var selectedTime: Date = Date.now
    @Query(sort: \AlarmModel.time) var alarms: [AlarmModel]
    @Environment(\.modelContext) private var modelContext
    @State var selectedDay: [Days] = []
    @State var timeZone: String = ""
    var body: some View {
        Form {
            DatePicker("Set Alarm Time",selection: $selectedTime, displayedComponents: .hourAndMinute)
            DayOfTheWeek(selectedDays: $selectedDay)
            Picker("Time zone", selection: $timeZone) {
                Text("Pacific Standard Time")
                Text("Eastern Standard Time")
                Text("Central Standard Time")
                Text("Mountain Standard Time")
            }
            Button(action: {addAlarm(); sendAlarmNotification(timeToSend: selectedTime, dayToSend: 7, timeZone: "Pacific Standard Time")}) {
                Text("Add Alarm")
            }
        }
    }
    
    private func addAlarm() {
        withAnimation {
            let newAlarm = AlarmModel(time: selectedTime, days: selectedDay, isEnabled: true)
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

