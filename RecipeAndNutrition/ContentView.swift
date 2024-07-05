//
//  ContentView.swift
//  RecipeAndNutrition
//
//  Created by marcelodearaujo on 01/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedNutritionType = "cooking"
    @State private var value = ""
    @State private var foodParam = ""
    @State private var selectedUnit = "g"
    @State private var nutritionResponse: NutritionResponse?
    @State private var errorMessage: String?
    @State private var selectedNumber = 0
    
    let serviceApi = ServiceApi()
    let units = ["g", "t", "tb", "oz", "kg", "cups", "ml"]
    let nutritionType = ["cooking", "logging"]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Picker("Nutrition Type", selection: $selectedNutritionType) {
                    ForEach(nutritionType, id: \.self) {
                        Text($0)
                    }
                }
                .padding(.top, 50)
                
                HStack {
                    TextField("Value", text: $value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.decimalPad)
                    
                    Picker("Unit", selection: $selectedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                TextField("Food Parameter", text: $foodParam)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                
                NavigationLink(destination: NutritionAnalysisView(nutritionResponse: nutritionResponse, errorMessage: errorMessage)) {
                    Text("Get Nutrition Analysis Completion")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top)
                .simultaneousGesture(TapGesture().onEnded {
                    serviceApi.getNutritionAnalysisCompletion(nutritionType: selectedNutritionType, value: value, unit: selectedUnit, foodParam: foodParam) { (code, response, error) in
                        if let response = response {
                            self.nutritionResponse = response
                            self.errorMessage = nil
                        } else if let error = error {
                            self.errorMessage = error.localizedDescription
                            self.nutritionResponse = nil
                        } else if let code = code {
                            self.errorMessage = code.message
                            self.nutritionResponse = nil
                        }
                    }
                })
                
                NavigationLink(destination: NutritionAnalysisView(nutritionResponse: nutritionResponse, errorMessage: errorMessage)) {
                    Text("Get Nutrition Analysis Async")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top)
                .simultaneousGesture(TapGesture().onEnded {
                    Task {
                        do {
                            let (responseCode, response) = try await serviceApi.getNutritionAnalysisAsync(
                                nutritionType: selectedNutritionType,
                                value: value,
                                unit: selectedUnit,
                                foodParam: foodParam
                            )
                            
                            if let response = response {
                                self.nutritionResponse = response
                                self.errorMessage = nil
                            } else if let code = responseCode {
                                self.errorMessage = code.message
                                self.nutritionResponse = nil
                            } else {
                                self.errorMessage = "Unknown error occurred"
                                self.nutritionResponse = nil
                            }
                        } catch {
                            self.errorMessage = error.localizedDescription
                            self.nutritionResponse = nil
                        }
                    }
                })
                
                NavigationLink(destination: NutritionAnalysisView(nutritionResponse: nutritionResponse, errorMessage: errorMessage)) {
                    Text("Get Nutrition Analysis Alamofire")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top)
                .simultaneousGesture(TapGesture().onEnded {
                    serviceApi.getNutritionAnalysisAlamofire(nutritionType: selectedNutritionType, value: value, unit: selectedUnit, foodParam: foodParam) { (code, response, error) in
                        if let response = response {
                            self.nutritionResponse = response
                            self.errorMessage = nil
                        } else if let error = error {
                            self.errorMessage = error.localizedDescription
                            self.nutritionResponse = nil
                        } else if let code = code {
                            self.errorMessage = code.message
                            self.nutritionResponse = nil
                        }
                    }
                })
                
                NavigationLink(destination: NutritionAnalysisView(nutritionResponse: nutritionResponse, errorMessage: errorMessage)) {
                    Text("Get Nutrition Analysis Combine")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top)
                .simultaneousGesture(TapGesture().onEnded {
                    serviceApi.getNutritionAnalysisCombine(nutritionType: selectedNutritionType, value: value, unit: selectedUnit, foodParam: foodParam) { (code, response, error) in
                        if let response = response {
                            self.nutritionResponse = response
                            self.errorMessage = nil
                        } else if let error = error {
                            self.errorMessage = error.localizedDescription
                            self.nutritionResponse = nil
                        } else if let code = code {
                            self.errorMessage = code.message
                            self.nutritionResponse = nil
                        }
                    }
                })
                
                NavigationLink(destination: NutritionAnalysisView(nutritionResponse: nutritionResponse, errorMessage: errorMessage)) {
                    Text("Get Nutrition Analysis Generics Completion")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.bottom)
                .simultaneousGesture(TapGesture().onEnded {
                    serviceApi.getNutritionAnalysisCompletionGenerics(
                        nutritionType: selectedNutritionType,
                        value: value,
                        unit: selectedUnit,
                        foodParam: foodParam,
                        responseType: NutritionResponse.self
                    ) { response, error in
                        if let response = response {
                            self.nutritionResponse = response
                            self.errorMessage = nil
                        } else if let error = error {
                            self.errorMessage = error.localizedDescription
                            self.nutritionResponse = nil
                        }
                    }
                })
                
                NavigationLink(destination: NutritionAnalysisView(nutritionResponse: nutritionResponse, errorMessage: errorMessage)) {
                    Text("Get Nutrition Analysis Async Generics")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.bottom)
                .simultaneousGesture(TapGesture().onEnded {
                    Task {
                        do {
                            let response: NutritionResponse = try await serviceApi.getNutritionAnalysisAsyncGenerics(
                                nutritionType: selectedNutritionType,
                                value: value,
                                unit: selectedUnit,
                                foodParam: foodParam,
                                responseType: NutritionResponse.self
                            )
                            self.nutritionResponse = response
                            self.errorMessage = nil
                        } catch {
                            self.errorMessage = error.localizedDescription
                            self.nutritionResponse = nil
                        }
                    }
                })
                
                Spacer()
            }
            .navigationTitle("Nutrition Analysis")
        }
    }
}
