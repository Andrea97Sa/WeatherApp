//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    @StateObject private var router = Router()

    var body: some Scene {
        
        WindowGroup {
            HomeView()
                .environmentObject(router)
                .onAppear() {
                    LocationManager.shared.setupLocationManager()
                }
        }
    }
}
