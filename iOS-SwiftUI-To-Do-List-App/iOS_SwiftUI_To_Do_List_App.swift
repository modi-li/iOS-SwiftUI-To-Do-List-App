//
//  iOS_SwiftUI_To_Do_List_App.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import SwiftUI
import SwiftData

@main
struct iOS_SwiftUI_To_Do_List_App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            ItemList.self
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
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}
