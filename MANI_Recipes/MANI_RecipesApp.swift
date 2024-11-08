//
//  MANI_RecipesApp.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI
import Alamofire
import Foundation

@main
struct MANI_RecipesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
