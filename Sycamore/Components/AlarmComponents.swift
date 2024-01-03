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
                Button(action: {isExapanded.toggle()}){
                    Image(systemName: "arrowshape.down.circle.fill")
                }
                Toggle("", isOn: $alarmIsOn)
            }
            if(isExapanded == true){
                AlarmDateSelector()
            }
        }
        .padding()
    }
}

struct AlarmForm: View {
    @State private var selectedTime: Date = Date.now
    @Query(sort: \AlarmModel.time) var alarms: [AlarmModel]
    @Environment(\.modelContext) private var modelContext
    var selectedDay = [Days]()
    var body: some View {
        Form {
            DatePicker("Set Alarm Time",selection: $selectedTime, displayedComponents: .hourAndMinute)
            DayOfTheWeek(selectedDays: selectedDay)
            Button(action: {addAlarm()}) {
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


struct AlarmDateSelector: View {
    @State var setDateOnSunday: Bool = false
    @State var setDateOnMonday: Bool = false
    @State var setDateOnTuesday: Bool = false
    @State var setDateOnWednesday: Bool = false
    @State var setDateOnThursday: Bool = false
    @State var setDateOnFriday: Bool = false
    @State var setDateOnSaturday: Bool = false
    var body: some View {
        HStack{
            Button(action: {setDateOnSunday.toggle()}){
                if(setDateOnSunday == false){
                    Image(systemName: "s.square")
                } else {
                    Image(systemName: "s.square.fill")
                }
            }
            Button(action: {setDateOnMonday.toggle()}){
                if(setDateOnMonday == false){
                    Image(systemName: "m.square")
                } else {
                    Image(systemName: "m.square.fill")
                }
            }
            Button(action: {setDateOnTuesday.toggle()}){
                if(setDateOnTuesday == false){
                    Image(systemName: "t.square")
                } else {
                    Image(systemName: "t.square.fill")
                }
            }
            Button(action: {setDateOnWednesday.toggle()}){
                if(setDateOnWednesday == false){
                    Image(systemName: "w.square")
                } else {
                    Image(systemName: "w.square.fill")
                }
            }
            Button(action: {setDateOnThursday.toggle()}){
                if(setDateOnThursday == false){
                    Image(systemName: "t.square")
                } else {
                    Image(systemName: "t.square.fill")
                }
            }
            Button(action: {setDateOnFriday.toggle()}){
                if(setDateOnFriday == false){
                    Image(systemName: "f.square")
                } else {
                    Image(systemName: "f.square.fill")
                }
            }
            Button(action: {setDateOnSaturday.toggle()}){
                if(setDateOnSaturday == false){
                    Image(systemName: "s.square")
                } else {
                    Image(systemName: "s.square.fill")
                }
            }
        }
    }
}

struct DayOfTheWeek: View {
    @State var selectedDays: [Days]
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

#Preview {
    AlarmForm()
}
