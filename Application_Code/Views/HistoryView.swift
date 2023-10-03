//
//  HistoryView.swift
//  DietFitFinal
//
//  Created by Kristy on 24/7/2023.
//

import SwiftUI

struct HistoryView: View {
    @State var selectedDate : Date
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var goExerciseList = false
    let calendar = Calendar.current
    
    private func fetchRecords() {
        Task {
            do {
                try await viewModel.fetchDietRecords(selectedDate: selectedDate)
                try await viewModel.fetchFitnessRecords(selectedDate: selectedDate)
                try await viewModel.fetchWeightRecords(selectedDate: selectedDate)

            } catch {
                print("Error fetching diet records: \(error)")
            }
        }
    }
    
    private var showRecordAlert : Binding<Bool> {
        if viewModel.fitnessRecords.isEmpty && viewModel.dietRecords.isEmpty && viewModel.weightRecords.isEmpty{
            return .constant(true)
        } else{
            return .constant(false)
        }
    }
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                //logo
                
                VStack(spacing:24){
                    Text("History")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    ScrollView(){
                        VStack (spacing:16){
                            PlanDateRow(selectedDate: $selectedDate)
                            
                            HStack{
                                Text("Weight")
                                    .font(Font.sentence)
                                    .foregroundColor(Color("green_text"))
                                    .padding(.leading, 16)
                                    .padding(.vertical,8)
                                
                                Spacer()
                                if let weightRecord = viewModel.weightRecords.first(where: { calendar.isDate($0.date, inSameDayAs: selectedDate) }) {
                                    Text("\(weightRecord.weight) kg")
                                        .padding(.trailing, 16)
                                } else {
                                    Text("-    kg")
                                        .padding(.trailing, 16)
                                }
                                
                                
                            }.background(.white)
                                .cornerRadius(5)
                            
                            VStack(spacing:4){
                                HomeCaloriePanel(consumed: viewModel.totalCalories, limit: viewModel.AMR, minimum: viewModel.BMR, target: viewModel.targetCalorie)
                                    .padding(.top,8)
                                
                                HStack{
                                    Image(systemName: "flag.fill")
                                        .foregroundColor(Color("green_text"))
                                    Text("Daily Limit")
                                        .foregroundColor(Color("green_text"))
                                        .font(Font.sentence)
                                    Spacer()
                                    Text("\(viewModel.AMR) kcal")
                                }.padding(.horizontal,16)
                                
                                HStack{
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(Color("green_text"))
                                    Text("Daily Target")
                                        .foregroundColor(Color("green_text"))
                                        .font(Font.sentence)
                                    Spacer()
                                    Text("\(viewModel.targetCalorie) kcal")
                                }.padding(.horizontal,16)
                                
                                HStack{
                                    Image(systemName: "fork.knife")
                                        .foregroundColor(Color("green_text"))
                                    Text("Calorie Intake")
                                        .foregroundColor(Color("green_text"))
                                        .font(Font.sentence)
                                        .padding(.leading, 4)
                                    Spacer()
                                    Text("\(viewModel.totalCalories) kcal")
                                }.padding(.horizontal,16)
                                
                                HStack{
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(Color("green_text"))
                                    Text("Basal Metabolic Rate")
                                        .foregroundColor(Color("green_text"))
                                        .font(Font.sentence)
                                    Spacer()
                                    Text("\(viewModel.BMR) kcal")
                                }.padding(.horizontal,16)
                                    .padding(.bottom,8)
                            }.background(Color.white)
                                .cornerRadius(5)
                                .frame(height: 150)
                                .padding(.vertical,8)
                                .padding(.bottom,4)
                            
                            HStack{
                                Spacer()
                                Text("Diet")
                                    .font(Font.sentence)
                                    .padding(8)
                                Spacer()
                            }.background(Color("text_background"))
                                .cornerRadius(5)
                            
                            VStack(spacing:16){
                                
                                AddFoodRowView(title: "Breakfast", selectedDate: $selectedDate, typeOfDiet:"Breakfast", records: $viewModel.breakfastRecords)
                                AddFoodRowView(title: "Lunch", selectedDate: $selectedDate, typeOfDiet: "Lunch", records: $viewModel.lunchRecords)
                                AddFoodRowView(title: "Dinner", selectedDate: $selectedDate, typeOfDiet: "Dinner", records: $viewModel.dinnerRecords)
                                AddFoodRowView(title: "Snack", selectedDate: $selectedDate, typeOfDiet: "Snack", records: $viewModel.snacksRecords)
                                
                                VStack (spacing:16){
                                    VStack(spacing:16){
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
                            
                            HStack{
                                Spacer()
                                Text("Fitness")
                                    .font(Font.sentence)
                                    .padding(8)
                                Spacer()
                            }.background(Color("text_background"))
                                .cornerRadius(5)
                            
                            ForEach(viewModel.fitnessRecords, id: \.id) { record in
                                FitnessRecord(
                                    recordName: record.name,
                                    recordImage: record.imageName,
                                    recordkg: record.weight,
                                    recordsets: record.sets,
                                    recordreps: record.reps
                                )
                            }
                        
                                Button {
                                    goExerciseList = true
                                } label: {
                                    HStack{
                                        Text("+ Add Exercise")
                                            .font(Font.sentence)
                                            .padding(.leading,20)
                                        Spacer()
                                    }.frame(width: 360, height:30)
                                        .background(.white)
                                        .cornerRadius(4)
                                        .foregroundColor(Color("grey_text"))
                                }.navigationDestination(isPresented: $goExerciseList) {
                                ExerciseListView( selectedDate: $selectedDate).environmentObject(FitnessItemViewModel())}
                            
                        }.frame(width: 360)
                        
                    }.onAppear {
                        fetchRecords()
                    }.onChange(of: selectedDate) { _ in
                        fetchRecords()
                    }
                }
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(selectedDate: Date())
            .environmentObject(AuthViewModel())
    }
}

