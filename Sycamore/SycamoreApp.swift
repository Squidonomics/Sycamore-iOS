//
//  SycamoreApp.swift
//  Sycamore
//
//  Created by Brian on 1/1/24.
//

import SwiftUI
import SwiftData

@main
struct SycamoreApp: App {
    let modelContainer: ModelContainer

    init() {
            do {
                modelContainer = try ModelContainer(for: AlarmModel.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }

    var body: some Scene {
        WindowGroup {
            AlarmView()
        }
        .modelContainer(modelContainer)
    }
}
