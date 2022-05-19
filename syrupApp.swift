//
//  syrupApp.swift
//  syrup
//
//  Created by Caio Soares on 11/05/22.
//

import SwiftUI

@main
struct syrupApp: App {
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            syrupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
