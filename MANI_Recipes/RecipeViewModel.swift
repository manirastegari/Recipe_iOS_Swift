//
//  RecipeViewModel.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import Foundation
import Alamofire

class RecipeViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var recipes: [Recipe] = []

    func fetchCategories() {
        let apiURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        AF.request(apiURL).responseDecodable(of: [String: [Category]].self) { response in
            switch response.result {
            case .success(let data):
                print("Categories fetched successfully: \(data)")
                self.categories = data["categories"] ?? []
            case .failure(let error):
                print("Failed to fetch categories: \(error)")
            }
        }
    }
    
    func fetchRecipes(for category: String) {
        let apiURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        
        AF.request(apiURL).responseDecodable(of: [String: [Recipe]].self) { response in
            switch response.result {
            case .success(let data):
                print("Recipes fetched successfully: \(data)")
                self.recipes = data["meals"] ?? []
            case .failure(let error):
                print("Failed to fetch recipes: \(error)")
            }
        }
    }
}