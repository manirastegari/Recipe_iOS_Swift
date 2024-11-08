//
//  ContentView.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CategoriesListView()
                .tabItem {
                    Label("Categories", systemImage: "list.bullet")
                }
            
            FavoriteListView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
