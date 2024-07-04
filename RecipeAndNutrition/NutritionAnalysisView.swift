//
//  NutritionAnalysisView.swift
//  RecipeAndNutrition
//
//  Created by marcelodearaujo on 04/07/24.
//

import SwiftUI

struct NutritionAnalysisView: View {
    var nutritionResponse: NutritionResponse?
    var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let response = nutritionResponse {
                    Group {
                        Text("General Information")
                            .font(.headline)
                            .padding(.bottom, 2)
                        
                        Text("Calories: \(response.calories, specifier: "%.1f") kcal")
                        Text("Total Weight: \(response.totalWeight, specifier: "%.1f") g")
                        Text("Total CO2 Emissions: \(response.totalCO2Emissions, specifier: "%.1f") g")
                        Text("CO2 Emissions Class: \(response.co2EmissionsClass)")
                    }
                    .padding()

                    Group {
                        Text("Labels")
                            .font(.headline)
                            .padding(.bottom, 2)

                        Text("Diet Labels: \(response.dietLabels.joined(separator: ", "))")
                        Text("Health Labels: \(response.healthLabels.joined(separator: ", "))")
                        Text("Cautions: \(response.cautions.joined(separator: ", "))")
                    }
                    .padding()

                    Group {
                        Text("Nutritional Information")
                            .font(.headline)
                            .padding(.bottom, 2)

                        ForEach(response.totalNutrients.keys.sorted(), id: \.self) { key in
                            if let nutrient = response.totalNutrients[key] {
                                Text("\(nutrient.label): \(nutrient.quantity, specifier: "%.2f") \(nutrient.unit)")
                            }
                        }
                    }
                    .padding()

                    Group {
                        Text("Daily Values")
                            .font(.headline)
                            .padding(.bottom, 2)

                        ForEach(response.totalDaily.keys.sorted(), id: \.self) { key in
                            if let nutrient = response.totalDaily[key] {
                                Text("\(nutrient.label): \(nutrient.quantity, specifier: "%.2f") \(nutrient.unit)")
                            }
                        }
                    }
                    .padding()

                    Group {
                        Text("Ingredients")
                            .font(.headline)
                            .padding(.bottom, 2)

                        ForEach(response.ingredients, id: \.self.text) { ingredient in
                            Text(ingredient.text)
                            ForEach(ingredient.parsed, id: \.self.foodID) { parsed in
                                VStack(alignment: .leading) {
                                    Text("Food: \(parsed.food)")
                                    Text("Quantity: \(parsed.quantity, specifier: "%.2f") \(parsed.measure)")
                                    ForEach(parsed.nutrients.keys.sorted(), id: \.self) { key in
                                        if let nutrient = parsed.nutrients[key] {
                                            Text("\(nutrient.label): \(nutrient.quantity, specifier: "%.2f") \(nutrient.unit)")
                                        }
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                    }
                    .padding()

                    Group {
                        Text("Calories Breakdown")
                            .font(.headline)
                            .padding(.bottom, 2)

                        Text("Calories from Protein: \(response.totalNutrientsKCal.procntKcal.quantity, specifier: "%.2f") kcal")
                        Text("Calories from Fat: \(response.totalNutrientsKCal.fatKcal.quantity, specifier: "%.2f") kcal")
                        Text("Calories from Carbohydrates: \(response.totalNutrientsKCal.chocdfKcal.quantity, specifier: "%.2f") kcal")
                    }
                    .padding()
                }
                
                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("Nutrition Analysis")
            .padding()
        }
    }
}

