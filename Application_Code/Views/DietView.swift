//
//  DietView.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI

struct DietView: View {
    @EnvironmentObject var viewModel : FoodItemViewModel
    @State public var foodSearchText : String = ""
    @Binding var selectedDate : Date
    @Binding var typeOfDiet : String
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:24){
                    Text("Diet")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    VStack (spacing: 12) {
                        VStack (spacing: 12){
                            TextField("Search", text: $foodSearchText)
                                .padding(.horizontal, 32)
                                .frame(height: 40)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("green_text"), lineWidth: 1))
                                .cornerRadius(8)
                                .frame(width:370)
                                .onChange(of: foodSearchText) { newValue in
                                    viewModel.filterFoodItems(searchText: newValue)
                                }
                        }
                        
                        if viewModel.filteredFoodItems.isEmpty {
                            Text("No record for this food item")
                                .foregroundColor(Color("green_text"))
                                .padding(.top, 20)
                            Spacer()
                            Spacer()
                        } else {
                            List{
                                ForEach(viewModel.filteredFoodItems, id:\.self) { item in
                                    
                                    NavigationLink(destination: FoodItemView(name: item.name, servingSize: item.serving_size_g, calories: item.calories, carbohydrates: item.carbohydrate_g, sugars: item.sugars_g, fibre: item.fiber_g, fat: item.total_fat_g, protein: item.protein_g,  saturatedFat: item.saturated_fat_g, sodium: item.sodium_mg, calcium: item.calcium_mg, iron: item.iron_mg, potassium: item.potassium_mg, vitaminA: item.vitamin_a_mcg, vitaminB12: item.vitamin_b12_mcg, vitaminB6: item.vitamin_b6_mg, vitaminC: item.vitamin_c_mg, vitaminE: item.vitamin_e_mg, selectedDate: $selectedDate, typeOfDiet: $typeOfDiet)) {
                                        Text(item.name)}
                                    
                                }
                            }.listStyle(PlainListStyle())
                                .cornerRadius(10)
                                .frame(width:360)
                        }
                    }
                }
                
                NavigationLink(destination: DietPlanView(typeOfDiet: .constant("Breakfast"))
                    .environmentObject(AuthViewModel())
                ) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("green_text"))
                        .background(.white)
                    
                }.padding(.top, 600)
                    .padding(.leading, 300)
            }
        }
    }
}

struct DietView_Previews: PreviewProvider {
    static var previews: some View {
        DietView(selectedDate: .constant(Date()), typeOfDiet: .constant("Breakfast"))
            .environmentObject(FoodItemViewModel())
    }
}
