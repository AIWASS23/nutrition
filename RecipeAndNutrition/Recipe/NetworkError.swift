//
//  NetworkError.swift
//  RecipeAndNutrition
//
//  Created by marcelodearaujo on 01/07/24.
//

import Foundation

enum NetworkError: Error {
    case statusIncorrect
    case dataMissing
    case urlMalformed
    case decodingFailed(_ error: Error)
    case unknown(_ error: Error)
}
