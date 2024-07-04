//
//  Recipe.swift
//  RecipeAndNutrition
//
//  Created by marcelodearaujo on 01/07/24.
//

import Foundation

struct RecipeResponse: Codable {
    let hits: [RecipeLinks]
    let _links: NextLink
    let from: Int
    let to: Int
    let count: Int
}

struct RecipeLinks: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let shareAs: String
    let yield: Int
    let dishType: [String]?
    let ingredientLines: [String]
    let calories: Double
    let totalTime: Double?
    let cuisineType: [String]?
}

struct NextLink: Codable {
    let next: Next?
}

struct Next: Codable {
    let href: String
    let title: String
}
