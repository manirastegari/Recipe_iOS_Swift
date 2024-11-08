//
//  RecipeDetailView.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI
import CoreData
import Alamofire

struct RecipeDetailView: View {
    let recipeId: String
    @State private var recipeDetail: RecipeDetail?
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Favorite.entity(),
        sortDescriptors: []
    ) private var favorites: FetchedResults<Favorite>
    @State private var showingSuccessAlert = false
    @State private var successMessage: String = ""
    
    var body: some View {
        ScrollView { 
            VStack {
                if let recipeDetail = recipeDetail {
                    Text(recipeDetail.strMeal)
                        .font(.largeTitle)
                    AsyncImage(url: recipeDetail.strMealThumb) { image in
                        image.resizable().frame(width: 200, height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(recipeDetail.strInstructions)
                        .padding()
                    Button(action: toggleFavorite) {
                        Label(isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: isFavorite ? "heart.fill" : "heart")
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .padding()
        }
        .onAppear {
            fetchRecipeDetail()
        }
        .navigationTitle("Recipe Details")
        .alert(isPresented: $showingSuccessAlert) {
            Alert(title: Text("Success"), message: Text(successMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var isFavorite: Bool {
        guard let recipeDetail = recipeDetail else { return false }
        return favorites.contains(where: { $0.id == recipeDetail.idMeal })
    }
    
    private func fetchRecipeDetail() {
        let apiURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeId)"
        AF.request(apiURL).responseDecodable(of: RecipeDetailResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.recipeDetail = data.meals.first
            case .failure(let error):
                print("Failed to fetch recipe details: \(error)")
            }
        }
    }
    
    private func toggleFavorite() {
        guard let recipeDetail = recipeDetail else { return }
        
        if isFavorite {
            removeFromFavorites(recipeDetail)
            successMessage = "Recipe removed from favorites!"
        } else {
            addToFavorites(recipeDetail)
            successMessage = "Recipe added to favorites!"
        }
        
        showingSuccessAlert = true
    }
    
    private func addToFavorites(_ recipeDetail: RecipeDetail) {
        let favorite = Favorite(context: viewContext)
        favorite.id = recipeDetail.idMeal
        favorite.name = recipeDetail.strMeal
        favorite.imageURL = recipeDetail.strMealThumb.absoluteString
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save favorite: \(error)")
        }
    }
    
    private func removeFromFavorites(_ recipeDetail: RecipeDetail) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest() as! NSFetchRequest<Favorite>
        fetchRequest.predicate = NSPredicate(format: "id == %@", recipeDetail.idMeal)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            for favorite in results {
                viewContext.delete(favorite)
            }
            try viewContext.save()
        } catch {
            print("Failed to remove favorite: \(error)")
        }
    }
}