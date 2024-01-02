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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            AlarmModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AlarmView()
        }
        .modelContainer(sharedModelContainer)
    }
}
