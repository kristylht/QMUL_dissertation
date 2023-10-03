//
//  FoodPlanSettingsView.swift
//  DietFitFinal
//
//  Created by Kristy on 19/7/2023.
//

import SwiftUI

struct DietPlanSettingsView: View {
    public let  name : String
    @State var servingRecord : String = ""
    @State var goDietPlanView : Bool  = false
    @Binding var selectedDate : Date
    @Binding var calories : Int
    @Binding var carbohydrates : Double
    @Binding var sugars : Double
    @Binding var fibre : Double
    @Binding var protein : Double
    @Binding var fat : Double
    @Binding var saturatedFat : Double
    @Binding var sodium : Double
    @Binding var calcium : Double
    @Binding var iron : Double
    @Binding var potassium : Double
    @Binding var vitaminA : Double
    @Binding var vitaminB12 : Double
    @Binding var vitaminB6 : Double
    @Binding var vitaminC : Double
    @Binding var vitaminE : Double
    @Binding var typeOfDiet : String
    @Binding var servingSize : Int
    @EnvironmentObject var viewModel : AuthViewModel
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:24){
                    Text(name)
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                        .multilineTextAlignment(.center)
                    
                    PlanDateRow(selectedDate: $selectedDate).frame(width: 360)
                    
                    HStack(spacing: 20) {
                        Text("Serving")
                            .font(.sentence)
                            .foregroundColor(Color("green_text"))
                        
                        Spacer()
                        
                        HStack{
                            TextField("20", text: $servingRecord)
                                .keyboardType(.numberPad)
                                .frame(width:45)
                            Text("g")
                        } .font(.answer)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.white)
                    .cornerRadius(5)
                    .frame(height: 20)
                    .frame(width: 360)
                    
                    let nutrition_size = Double(Int(servingRecord) ?? 0) / Double(servingSize)
                    
                    Button(action: {
                        Task{
                            
                            viewModel.addDietRecord(dateOfDiet: selectedDate, typeOfDiet: typeOfDiet, size: Int(servingRecord) ?? 0, name: name, calories: Int(Double(calories) * nutrition_size), carbohydrates: carbohydrates * nutrition_size, sugar: sugars * nutrition_size, fibre: fibre * nutrition_size, protein: protein * nutrition_size, fat: fat * nutrition_size, saturatedFat: saturatedFat * nutrition_size, calcium: calcium * nutrition_size, sodium: sodium * nutrition_size, iron: iron * nutrition_size, potassium: potassium * nutrition_size, vitaminA: vitaminA * nutrition_size, vitaminB6: vitaminB6 * nutrition_size,vitaminB12: vitaminB12 * nutrition_size,vitaminC: vitaminC * nutrition_size,vitaminE: vitaminE * nutrition_size)
                            goDietPlanView  = true
                            
                        }
                    }) {
                        Text("Confirm")
                            .font(.sentence)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 360)
                            .background(Color("text_background"))
                            .cornerRadius(5)
                        
                    }
                    .navigationDestination(isPresented: $goDietPlanView) {
                        DietPlanView(typeOfDiet: .constant("Breakfast"))
                            .environmentObject(AuthViewModel())
                            .navigationBarBackButtonHidden()
                            .onAppear {
                                goDietPlanView = false}
                    }
                    
                    Spacer()
                    
                }
            }
        }
    }
}

struct DietPlanSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DietPlanSettingsView(name:"some food", selectedDate: .constant(Date()), calories: .constant(0), carbohydrates: .constant(0), sugars: .constant(0),fibre: .constant(0), protein: .constant(0), fat: .constant(0), saturatedFat: .constant(0), sodium:  .constant(0), calcium:  .constant(0),iron:  .constant(0), potassium:  .constant(0), vitaminA:  .constant(0), vitaminB12:  .constant(0), vitaminB6:  .constant(0), vitaminC:  .constant(0), vitaminE:  .constant(0), typeOfDiet: .constant("Breakfast"), servingSize: .constant(0))
            .environmentObject(AuthViewModel())
    }
}
