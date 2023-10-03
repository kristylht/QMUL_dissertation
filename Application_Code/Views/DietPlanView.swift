//
//  DietPlanView.swift
//  DietFitFinal
//
//  Created by Kristy on 18/7/2023.
//

import SwiftUI

struct DietPlanView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State var selectedDate : Date = Date()
    @Binding var typeOfDiet : String
    
    private func fetchDietRecords() {
        Task {
            do {
                try await viewModel.fetchDietRecords(selectedDate: selectedDate)
            } catch {
                print("Error fetching diet records: \(error)")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                ZStack{
                    
                    VStack(spacing:24){
                        Text("Your Diet")
                            .padding([.bottom],10)
                            .frame(maxWidth:.infinity)
                            .font(Font.signInTitle)
                            .foregroundColor(.black)
                            .background(.white)
                        
                        ScrollView{
                            VStack(spacing:24){
                                PlanDateRow(selectedDate: $selectedDate)
                                
                                AddFoodRowView(title: "Breakfast", selectedDate: $selectedDate, typeOfDiet:"Breakfast", records: $viewModel.breakfastRecords)
                                AddFoodRowView(title: "Lunch", selectedDate: $selectedDate, typeOfDiet: "Lunch", records: $viewModel.lunchRecords)
                                AddFoodRowView(title: "Dinner", selectedDate: $selectedDate, typeOfDiet: "Dinner", records: $viewModel.dinnerRecords)
                                AddFoodRowView(title: "Snack", selectedDate: $selectedDate, typeOfDiet: "Snack", records: $viewModel.snacksRecords)
                                
                                Divider()
                                
                                VStack (spacing:20){
                                    
                                    VStack(spacing:16){
                                        CaloriePanel(title: "Calories", consumed:  viewModel.totalCalories , limit: viewModel.AMR, minimum: viewModel.BMR, unit: "kcal", target: viewModel.targetCalorie)
                                            .padding(.top, 16)
                                        MacroNutrientPanel(title: "Carbohyrates", consumed: viewModel.totalCarbohydrates, limit: viewModel.carbohydratesRequirement, unit: "g")
                                        MacroNutrientPanel(title: "Protein", consumed: viewModel.totalProtein, limit: viewModel.proteinRequirement, unit: "g")
                                        MacroNutrientPanel(title: "Fat", consumed: viewModel.totalFat, limit: viewModel.fatRequirement, unit: "g")
                                    }.padding(.vertical,12)
                                        .padding(.bottom, 4)
                                        .background(.white)
                                        .cornerRadius(5)
                                    
                                    VStack(spacing:16){
                                        MicroNutrientPanel(title: "Fibre", consumed: viewModel.totalFibre, limit: viewModel.fibreRequirement, unit: "g")
                                        MicroNutrientPanel(title: "Sugar", consumed: viewModel.totalSugar, limit: viewModel.sugarRequirement, unit: "g")
                                        MicroNutrientPanel(title: "Saturated Fat", consumed: viewModel.totalSaturatedFat, limit: viewModel.satFatRequirement, unit: "g")
                                    }.padding(.vertical,12)
                                        .padding(.bottom, 4)
                                        .background(.white)
                                        .cornerRadius(5)
                                    
                                    VStack(spacing:16){
                                        MicroNutrientPanel(title: "Calcium", consumed: viewModel.totalCalcium, limit: viewModel.calciumRequirement, unit: "mg")
                                        MicroNutrientPanel(title: "Sodium", consumed: viewModel.totalSodium, limit: viewModel.sodiumRequirement, unit: "mg")
                                        MicroNutrientPanel(title: "Iron", consumed: viewModel.totalIron, limit: viewModel.satFatRequirement, unit: "mg")
                                        MicroNutrientPanel(title: "Potassium", consumed: viewModel.totalPotassium, limit: viewModel.potassiumRequirement, unit: "mg")
                                        MicroNutrientPanel(title: "Vitamin A", consumed: viewModel.totalVitaminA, limit: viewModel.vitaminARequirement, unit: "mcg")
                                        MicroNutrientPanel(title: "Vitamin B6", consumed: viewModel.totalVitaminB6, limit: viewModel.vitaminB6Requirement, unit: "mg")
                                        MicroNutrientPanel(title: "VitaminB12", consumed: viewModel.totalVitaminB12, limit: viewModel.vitaminB12Requirement, unit: "mcg")
                                        MicroNutrientPanel(title: "Vitamin C", consumed: viewModel.totalVitaminC, limit: viewModel.vitaminCRequirement, unit: "mg")
                                        MicroNutrientPanel(title: "Vitamin E", consumed: viewModel.totalVitaminE, limit: viewModel.vitaminERequirement, unit: "mg")
                                    }.padding(.vertical,12)
                                        .padding(.bottom, 4)
                                        .background(.white)
                                        .cornerRadius(5)
                                    
                                }
                            }.padding(.top,4)
                        }.frame(width: 360)
                    }
                }
            }
        }.onAppear {
            fetchDietRecords()
        }.onChange(of: selectedDate) { _ in
            fetchDietRecords()
        }
    }
}

struct DietPlanView_Previews: PreviewProvider {
    static var previews: some View {
        DietPlanView(typeOfDiet: .constant("Breakfast"))
            .environmentObject(AuthViewModel())
    }
}
