////
////  AppNavigation.swift
////  AlNaham
////
////  Created by Nouf Alshawoosh on 04/03/2026.
////
//
//
////
////  AlNahamApp.swift
////  AlNaham
////
////  Created by ruam on 10/08/1447 AH.
////
//
//import SwiftUI
//import Combine
//
//// Shared navigation state accessible anywhere in the app
//class AppNavigation: ObservableObject {
//    @Published var path = NavigationPath()
//}
//
//@main
//struct AlNahamApp: App {
//    @StateObject private var nav = AppNavigation()
//
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack(path: $nav.path) {
//                SplashScreenView()
//                    .navigationDestination(for: String.self) { value in
//                        if value == "startjourney" {
//                            StartJourney()
//                        } else if value.hasPrefix("guide-") {
//                            let duration = Int(value.replacingOccurrences(of: "guide-", with: "")) ?? 360
//                            GuideView(sessionDuration: duration)
//                        } else if value.hasPrefix("breathing-") {
//                            let duration = Int(value.replacingOccurrences(of: "breathing-", with: "")) ?? 360
//                            BreathingScreenView(sessionDuration: duration)
//                        }
//                    }
//            }
//            .environmentObject(nav)
//        }
//    }
//}
