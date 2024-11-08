//
//  CategoriesListView.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI
import Alamofire

struct FavoriteRecipeDetailView: View {
    let recipeId: String
    @State private var recipeDetail: RecipeDetail?

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
}