//
//  GoalView.swift
//  DietFitFinal
//
//  Created by Kristy on 6/7/2023.
//

import SwiftUI
import FirebaseFirestore

struct GoalView: View {
    @State private var gender: String = "Male"
    @State private var dateOfBirth : Date = Date()
    @State private var height : String = ""
    @State private var weight : String = ""
    @State private var selectedActivityLevel = "Sedentary"
    let activityLevel = ["Sedentary", "Lightly active", "Moderately active", "Active", "Very active"]
    @State private var targetWeight : String = ""
    @State private var targetDate : Date = Date()
    
    @EnvironmentObject var viewModel : AuthViewModel
    
 

    var body: some View {
        NavigationView{
            NavigationStack {
                ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack{
                    HStack{ Text("Personal Information")
                            .padding([.bottom],10)
                            .frame(maxWidth:.infinity)
                            .font(Font.signInTitle)
                            .foregroundColor(.black)
                            .background(.white)
                    }
                    
                    List{
                        
                        Section  {
                            // Gender
                            Group{
                                HStack{
                                    Text("Gender")
                                        .font(.sentence)
                                    
                                    Spacer()
                                    
                                    Picker("Gender", selection: $gender) {
                                        Text("Male").tag("Male")
                                        Text("Female").tag("Female")
                                    }.pickerStyle(.segmented)
                                        .frame(width:175)
                                }
                                
                                // Date of Birth
                                HStack{
                                    DatePicker(selection: $dateOfBirth, in: ...Date.now, displayedComponents: .date) {
                                        Text("Date of Birth")
                                            .font(.sentence)
                                    }
                                }
                                
                                // Height
                                HStack{
                                    Text("Height")
                                        .font(.sentence)
                                    
                                    Spacer()
                                    
                                    HStack{
                                        TextField("160", text: $height)
                                            .keyboardType(.numberPad)
                                            .frame(width:40)
                                        Text("cm")
                                    }
                                    
                                }
                                
                                
                                // Weight
                                HStack{
                                    Text("Current Weight")
                                        .font(.sentence)
                                    
                                    Spacer()
                                    
                                    HStack{
                                        TextField("60", text: $weight)
                                            .keyboardType(.numberPad)
                                            .frame(width:45)
                                        Text("kg")
                                    }
                                    
                                }
                                
                                HStack{
                                    Text("Activity Level")
                                        .font(.sentence)
                                    
                                    Spacer()
                                    
                                    Picker("",selection: $selectedActivityLevel) {
                                        
                                            ForEach(activityLevel, id: \.self) {
                                                Text($0).tag("\($0)")
                                            }
                                    }
                                    
                                }
                            }
                        }
                        
                        Section("Goals"){
                            HStack{
                                Text("Target Weight")
                                    .font(.sentence)
                                
                                Spacer()
                                
                            // Target Weight
                                HStack{
                                    TextField("60", text: $targetWeight)
                                        .keyboardType(.numberPad)
                                        .frame(width:45)
                                    Text("kg")
                                }
                                
                            }
                            
                            // Target Date
                            HStack{
                                DatePicker(selection: $targetDate, in: Date.now..., displayedComponents: .date) {
                                    Text("Target Date")
                                        .font(.sentence)
                                }
                            }
                        }
                       
                        
                     } .frame(width: 390)
                        .listStyle(.insetGrouped)
                    
                    
                   
                               VStack {
                                   Button {
                                       Task {
                                           //send user info to Firebase
                                           viewModel.updateDateOfBirth(dateOfBirth: dateOfBirth)
                                           viewModel.updateHeight(height: height)
                                           viewModel.updateWeight(weight: weight)
                                           viewModel.updateTargetWeight(targetWeight: targetWeight)
                                           viewModel.updateTargetDate(targetDate: targetDate)
                                           viewModel.showMainView = true
                                           viewModel.showGoalView = false
                                       }
                                       
                                   } label: {
                                       
                                       Text("Confirm")
                                           .font(Font.sentence)
                                           .frame(width: 330, height:50)
                                           .background(
                                               RoundedRectangle(cornerRadius: 4)
                                                   .fill(Color("text_background"))
                                           )
                                           .foregroundColor(.black)
                                           .padding(8)
                                   }
                              }
                               .navigationDestination(isPresented: $viewModel.showMainView) {
                                   MainView( selectedTab: .constant(.home)).navigationBarBackButtonHidden()
                              }
                    }
                    
                 

                        
                    
                    Spacer()
                    
                }
                
            }
        }
    }
}


struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            .environmentObject(AuthViewModel())
    }
}



