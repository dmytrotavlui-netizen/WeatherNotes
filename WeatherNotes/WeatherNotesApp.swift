//
//  WeatherNotesApp.swift
//  WeatherNotes
//
//  Created by Dixon on 27.02.2026.
//

import SwiftUI
import CoreData

@main
struct WeatherNotesApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
