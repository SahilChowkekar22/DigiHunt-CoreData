//
//  DigiHuntApp.swift
//  DigiHunt
//
//  Created by Sahil ChowKekar on 3/3/25.
//

import SwiftUI

@main
struct DigiHuntApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
//            ContentView()
            DigimonListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
