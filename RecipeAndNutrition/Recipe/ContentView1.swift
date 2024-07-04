//
//  ContentView1.swift
//  RecipeAndNutrition
//
//  Created by marcelodearaujo on 03/07/24.
//

import SwiftUI

struct ContentView1: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var searchTerm: String = ""
    @State private var dishType: String = ""
    @State private var hasType: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search term", text: $searchTerm)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Toggle(isOn: $hasType) {
                    Text("Filter by Dish Type")
                }
                .padding()
                
                if hasType {
                    TextField("Dish Type", text: $dishType)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    viewModel.getRecipes(searchTerm: searchTerm, dishType: dishType, hasType: hasType)
                }) {
                    Text("Search Recipes")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                List(viewModel.recipes, id: \.uri) { recipe in
                    VStack(alignment: .leading) {
                        Text(recipe.label)
                            .font(.headline)
                        if let imageUrl = URL(string: recipe.image) {
                            AsyncImage(url: imageUrl) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                }
                            }
                        }
                        Text("Calories: \(recipe.calories, specifier: "%.2f")")
                        Text("Total Time: \(recipe.totalTime ?? 0, specifier: "%.2f") minutes")
                    }
                }
                .navigationTitle("Recipes")
            }
            .padding()
        }
    }
}

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?

    func getRecipes(searchTerm: String, dishType: String, hasType: Bool) {
        ApiService.shared.getRecipes(searchTerm: searchTerm, type: dishType, hasType: hasType, const: false, urlConst: "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.recipes = response.hits.map { $0.recipe }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
