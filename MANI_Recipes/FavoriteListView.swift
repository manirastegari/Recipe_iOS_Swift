//
//  FavoriteListView.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI
import CoreData

struct FavoriteListView: View {
    @FetchRequest(
        entity: Favorite.entity(),
        sortDescriptors: []
    ) var favorites: FetchedResults<Favorite>
    @Environment(\.managedObjectContext) private var viewContext

    @State private var showingAlert = false
    @State private var favoriteToDelete: Favorite?

    var body: some View {
        NavigationView {
            List {
                ForEach(favorites) { favorite in
                    NavigationLink(destination: FavoriteRecipeDetailView(recipeId: favorite.id ?? "")) {
                        HStack {
                            AsyncImage(url: URL(string: favorite.imageURL ?? "")) { image in
                                image.resizable().frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(favorite.name ?? "Unknown")
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            favoriteToDelete = favorite
                            showingAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Delete Favorite"),
                    message: Text("Are you sure you want to delete this favorite?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let favoriteToDelete = favoriteToDelete {
                            deleteFavorite(favoriteToDelete)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .navigationTitle("Favorites")
        }
    }

    private func deleteFavorite(_ favorite: Favorite) {
        withAnimation {
            viewContext.delete(favorite)
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete favorite: \(error)")
            }
        }
    }
}