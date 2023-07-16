//
//  RelieveApp.swift
//  Relieve
//
//  Created by Student25 on 16/06/2023.
//

import SwiftUI
import CoreLocation
import Firebase
@main
struct RelieveApp: App {
    @StateObject private var vm = LocationViewModel()
    @StateObject var searchViewModel = LocationSearchViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LocationVIew().environmentObject(vm).environmentObject(searchViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
