//
//  CategoriesListView.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import SwiftUI

struct CategoriesListView: View {
    @ObservedObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: RecipesListView(category: category.strCategory)) {
                    HStack {
                        AsyncImage(url: category.strCategoryThumb) { image in
                            image.resizable().frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(category.strCategory)
                    }
                }
            }
            .navigationTitle("Categories")
            .onAppear {
                viewModel.fetchCategories()
            }
        }
    }
//    #Preview {
//        CategoriesListView()
//    }
}
