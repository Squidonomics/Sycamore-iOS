//
//  AlarmComponents.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import Foundation
import SwiftUI

struct AlarmListItem: View {
    @State private var isExapanded: Bool = false
    @State var alarmIsOn: Bool
    @State var setAlarmTime: String
    var body: some View {
        VStack{
            HStack{
                Text($setAlarmTime.wrappedValue)
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

struct BigAlarmSelector: View {
    @State private var selectedTime: Date = Date.now
    var body: some View {
        DatePicker("",selection: $selectedTime, displayedComponents: .hourAndMinute)
            .labelsHidden()
            .frame(width: 150, height: 100, alignment: .center)
            .compositingGroup()
            .clipped()
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

#Preview {
    AlarmListItem(alarmIsOn: true, setAlarmTime: "7:23 PM")
}
