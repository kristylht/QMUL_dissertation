//
//  HomeAddFoodRow.swift
//  DietFitFinal
//
//  Created by Kristy on 24/7/2023.
//

import SwiftUI

struct HomeAddFoodRow: View {
    @StateObject var viewModel = AuthViewModel()
    
    private func fetchDietRecords() async {
        Task {
            do {
                try await viewModel.fetchDietRecords(selectedDate: Date())
                print(viewModel.breakfastRecords)
            } catch {
                print("Error fetching fitness records: \(error)")
            }
        }
    }
    
    var body: some View {
        VStack(spacing:12){
            
            VStack (spacing:4){
                HomeCaloriePanel(consumed: viewModel.totalCalories, limit: viewModel.AMR, minimum: viewModel.BMR, target: viewModel.targetCalorie)
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
            }.background(.white)
                .cornerRadius(5)
                .frame(height: 160)
            
            VStack{
                FoodRow(title: "Breakfast", typeOfDiet: "Breakfast", records: $viewModel.breakfastRecords)
                    .padding(.top, 12)
                FoodRow(title: "Lunch", typeOfDiet: "Lunch", records: $viewModel.lunchRecords)
                FoodRow(title: "Dinner", typeOfDiet: "Dinner", records: $viewModel.dinnerRecords)
                FoodRow(title: "Snacks", typeOfDiet: "Snack", records: $viewModel.snacksRecords)
                
            }.background(.white)
                .cornerRadius(5)
        }.task {
            await fetchDietRecords()
        }
        .frame(width: 360)
    }
}


struct FoodRow: View {
    var title: String
    @State var typeOfDiet : String
    @State private var goDietView : Bool = false
    @Binding var records: [EachDietRecord]
    @StateObject var viewModel = AuthViewModel()
    
    
    
    var body: some View {
        
        HStack{
            VStack(alignment:.leading){
                
                
                Text(title)
                    .foregroundColor(Color("green_text"))
                    .font(Font.sentence)
                
                if !records.isEmpty {
                    ForEach($records, id: \.self) { record in
                        DietRecordRow(name: record.name, calories: record.calories)
                    }
                    
                    Button {
                        typeOfDiet = typeOfDiet
                        goDietView = true
                    } label: {
                        Text("+ Add Food")
                            .foregroundColor(Color("grey_text"))
                            .font(Font.sentence)
                    }
                    Divider()
                } else {
                    
                    Button {
                        typeOfDiet = typeOfDiet
                        goDietView = true
                    } label: {
                        Text("+ Add Food")
                            .foregroundColor(Color("grey_text"))
                            .font(Font.sentence)
                    }
                    Divider()
                }
                
            }
                .padding(.leading, 16)
            Spacer()
        }
        .frame(width:360)
        .navigationDestination(isPresented: $goDietView) {
            DietView( selectedDate: .constant(Date()), typeOfDiet: $typeOfDiet)
                .environmentObject(FoodItemViewModel())
                .onAppear {
                    goDietView = false}}
    }
}

struct HomeCaloriePanel: View {
    var consumed: Int
    var limit: Int
    var minimum : Int
    var target : Int
    
    private var progress: Double {
        guard limit != 0 else { return 0 }
        return Double(consumed) / Double(limit)
    }
    
    private var minimumCalorie: Double {
        guard minimum != 0 else { return 0 }
        return Double(minimum) / Double(limit)
    }
    
    private var targetDot: Double {
        guard target != 0 else { return 0 }
        return Double(target) / Double(limit)
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            HStack{
                Spacer()
                Text("\(Int(progress*100)) %")
                    .foregroundColor(.gray)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width, height: 8)
                    
                    Rectangle()
                        .foregroundColor(Color("green_text"))
                        .frame(width: min(geometry.size.width, geometry.size.width * CGFloat(progress)), height: 8)
                    
                    Rectangle()
                        .foregroundColor(Color("dot"))
                        .frame(width: 10, height: 8)
                        .position(x: min(geometry.size.width, geometry.size.width * CGFloat(minimumCalorie)), y: 4)
                    
                    Rectangle()
                        .foregroundColor(.yellow)
                        .frame(width: 10, height: 8)
                        .position(x: min(geometry.size.width, geometry.size.width * CGFloat(targetDot)), y: 4)
                    
                }.frame(height: 8)
                
                
            }
            
            VStack{
                if Int(consumed) < Int(minimum){
                    HStack{
                        Spacer()
                        Text("You have not meet the minimum energy requirement")
                            .font(Font.tinyDescription)
                            .foregroundColor(Color("green_text"))
                        Spacer()
                    }
                } else if Int(consumed) > Int(limit){
                    HStack{
                        Spacer()
                        Text("You have exceeded your daily limit ")
                            .font(Font.tinyDescription)
                            .foregroundColor(Color("green_text"))
                        Spacer()
                    }
                } else {
                    HStack{
                        Spacer()
                        Text("You are in the right range!")
                            .font(Font.tinyDescription)
                            .foregroundColor(Color("green_text"))
                        Spacer()
                    }
                    
                }
            }.padding(.vertical,12)
            
        }.padding([.leading, .trailing])
            .frame(height: 50)
            .padding(.top, 12)
    }
}


struct HomeAddFoodRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeAddFoodRow()
            .environmentObject(AuthViewModel())
    }
}

