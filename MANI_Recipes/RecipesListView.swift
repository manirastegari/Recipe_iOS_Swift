//
//  RecipesListView.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI

struct RecipesListView: View {
    let category: String
    @ObservedObject var viewModel = RecipeViewModel()
    
    var body: some View {
        List(viewModel.recipes) { recipe in
            NavigationLink(destination: RecipeDetailView(recipeId: recipe.idMeal)) {
                HStack {
                    AsyncImage(url: recipe.strMealThumb) { image in
                        image.resizable().frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(recipe.strMeal)
                }
            }
        }
        .navigationTitle(category)
        .onAppear {
            viewModel.fetchRecipes(for: category)
        }
    }
    
    
//    #Preview {
//        RecipesListView()
//    }
}
