//
//  TaekwonCalendarApp.swift
//  TaekwonCalendar
//
//  Created by 최은성 on 2022/05/11.
//

import SwiftUI
import Firebase

@main
struct TaekwonCalendarApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var contentViewModel = ContentViewModel()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginView()
                .environmentObject(contentViewModel)
//            StudentIDView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
