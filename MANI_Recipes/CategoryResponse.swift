//
//  CategoryResponse.swift
//  MANI_Recipes
//
//  Created by Mani Rastegari on 2024-11-07.
//

import Foundation

struct Category: Identifiable, Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: URL
    let strCategoryDescription: String
    
    var id: String { idCategory }
}
