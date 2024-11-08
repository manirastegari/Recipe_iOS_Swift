//
//  ReceiptResponse.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: URL
    
    var id: String { idMeal }
}
