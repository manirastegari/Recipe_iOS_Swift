//
//  RecipeDetailsResponse.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import Foundation

struct RecipeDetailResponse: Decodable {
    let meals: [RecipeDetail]
}

