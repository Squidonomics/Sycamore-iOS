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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        registerForNotification()
        return true
    }
    
    
    func registerForNotification() {
        UIApplication.shared.registerForRemoteNotifications()
        
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
            else {
                
            }
        })
    }
}
