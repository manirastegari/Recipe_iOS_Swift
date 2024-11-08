//
//  RecipeDetail.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import Foundation

struct RecipeDetail: Decodable, Equatable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
    let strInstructions: String
    var id: String { idMeal }
}