//
//  pomodoroSimpleApp.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 18/09/24.
//

import SwiftUI
import SwiftData

@main
struct pomodoroSimpleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            HomeView()
        }
        //.modelContainer(sharedModelContainer)
    }
}
