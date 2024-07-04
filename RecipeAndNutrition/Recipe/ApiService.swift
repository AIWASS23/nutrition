//
//  ApiService.swift
//  RecipeAndNutrition
//
//  Created by marcelodearaujo on 01/07/24.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    private init() {}
    
    func getRecipes(
        searchTerm: String,
        type: String,
        hasType: Bool,
        const: Bool,
        urlConst: String,
        completion: @escaping (Result<RecipeResponse, NetworkError>) -> Void
    ){
            
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/api/recipes/v2"
        
        if !hasType {
            urlComponents.queryItems = [
                URLQueryItem(name: "type", value: "public"),
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "app_id", value: "aca98564"),
                URLQueryItem(name: "app_key", value: "74e64ac4015444965deeb373be2d52ce"),
            ]
        }
        else {
            urlComponents.queryItems = [
                URLQueryItem(name: "type", value: "public"),
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "app_id", value: "aca98564"),
                URLQueryItem(name: "app_key", value: "74e64ac4015444965deeb373be2d52ce"),
                URLQueryItem(name: "dishType", value: type),
            ]
        }
        
        guard var url = urlComponents.url else {
            completion(.failure(.urlMalformed))
            return
        }
        if const {
            url = URL(string: urlConst)!
        }
        let task = URLSession.shared.dataTask(with: url) {data, urlResponse, error in
            guard error == nil else {
                completion(.failure(.unknown(error!)))
                return
            }
            
            guard let httpResponse = urlResponse as? HTTPURLResponse, (200..<400).contains(httpResponse.statusCode) else {
                completion(.failure(.statusIncorrect))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataMissing))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(RecipeResponse.self, from: data)
                
                print("Recipes: \(result.hits.count)")
                completion(.success(result))
            }
            catch {
                completion(.failure(.decodingFailed(error)))
                return
            }
        }
        task.resume()
    }
}
