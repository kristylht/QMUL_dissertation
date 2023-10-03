//
//  FoodItemView.swift
//  DietFitFinal
//
//  Created by Kristy on 18/7/2023.
//

import SwiftUI

struct FoodItemView: View {
    public let  name : String
    @State var servingSize : Int = 0
    @State var calories : Int = 0
    @State var carbohydrates : Double = 0
    @State var sugars : Double = 0
    @State var fibre : Double = 0
    @State var fat : Double = 0
    @State var protein : Double = 0
    @State var saturatedFat : Double = 0
    @State var sodium : Double = 0
    @State var calcium : Double = 0
    @State var iron : Double = 0
    @State var potassium : Double = 0
    @State var vitaminA : Double = 0
    @State var vitaminB12 : Double = 0
    @State var vitaminB6 : Double = 0
    @State var vitaminC : Double = 0
    @State var vitaminE : Double = 0
    @State private var goDietPlanSettingsView = false
    @Binding var selectedDate : Date
    @Binding var typeOfDiet : String 
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:8){
                    
                    Text(name)
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                        .multilineTextAlignment(.center)
                    
                    ScrollView{
                        FoodDetail(title: "Serving Size", value: servingSize, unit: "g")
                        FoodDetail(title: "Energy", value: calories, unit: "kcal")
                        
                        VStack (spacing:2){
                            HStack {
                                Text("Carbohydrates")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", carbohydrates as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                            
                            HStack {
                                Text("...Fibre")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("grey_text"))
                                    .font(Font.nutrition)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", fibre as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                                .foregroundColor(Color("grey_text"))
                            }
                            
                            HStack {
                                Text("...Sugar")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("grey_text"))
                                    .font(Font.nutrition)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", sugars as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                                .foregroundColor(Color("grey_text"))
                            }
                            
                            HStack {
                                Text("Fat")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", fat as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                            
                            HStack {
                                Text("...Saturated Fat")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("grey_text"))
                                    .font(Font.nutrition)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", saturatedFat as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                                .foregroundColor(Color("grey_text"))
                            }
                            
                            HStack {
                                Text("Protein")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", protein as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                        }.frame(height: 150)
                            .background(.white)
                            .cornerRadius(5)
                        
                        
                        FoodDetail(title: "Sodium", value: sodium, unit: "mg")
                        FoodDetail(title: "Calcium", value: calcium, unit: "mg")
                        FoodDetail(title: "Iron", value: iron, unit: "mg")
                        FoodDetail(title: "Potassium", value: potassium, unit: "mg")
                        
                        VStack (spacing:4){
                            HStack {
                                Text("Vitamin A")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", vitaminA as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                            
                            HStack {
                                Text("Vitamin B6")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", vitaminB6 as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                            
                            HStack {
                                Text("Vitamin B12")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", vitaminB12 as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                            
                            HStack {
                                Text("Vitamin C")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", vitaminC as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                            
                            HStack {
                                Text("Vitamin E")
                                    .padding(.leading,16)
                                    .foregroundColor(Color("green_text"))
                                    .font(Font.sentence)
                                
                                Spacer()
                                
                                HStack(spacing:4){
                                    Text(String(format: "%.2f", vitaminE as CVarArg))
                                    Text("g")}
                                .font(.answer)
                                .padding(.trailing, 16)
                            }
                        }.frame(height: 140)
                            .background(.white)
                            .cornerRadius(5)
                        
                        
                        Button(action: {goDietPlanSettingsView = true
                        }) {
                            Text("+ Add to Your Diet Plan")
                                .font(.sentence)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 360)
                                .background(Color("text_background"))
                                .cornerRadius(5)
                            
                        }
                        .navigationDestination(isPresented: $goDietPlanSettingsView) {
                            DietPlanSettingsView(name:name, selectedDate: $selectedDate, calories: $calories, carbohydrates: $carbohydrates, sugars: $sugars ,fibre: $fibre, protein: $protein, fat: $fat, saturatedFat: $saturatedFat, sodium:  $sodium, calcium: $calcium, iron: $iron, potassium: $potassium, vitaminA: $vitaminA, vitaminB12: $vitaminB12, vitaminB6:  $vitaminB6, vitaminC: $vitaminC, vitaminE: $vitaminE, typeOfDiet: $typeOfDiet, servingSize: $servingSize )
                                .environmentObject(AuthViewModel())
                                .onAppear {
                                    goDietPlanSettingsView = false}
                        }
                    }.frame(width: 360)
                }
            }
        }
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(name: "Oil, principal use as a tortilla shortening, soy (partially hydrogenated)  and cottonseed, industrial", selectedDate: .constant(Date()), typeOfDiet: .constant("Breakfast") )
    }
}
