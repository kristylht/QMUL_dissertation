//
//  PlanSettingsView.swift
//  DietFitFinal
//
//  Created by Kristy on 15/7/2023.
//

import SwiftUI

struct PlanSettingsView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @Binding var name : String
    @State var weight : String = ""
    @State private var reps : String = ""
    @State private var sets : String = ""
    @State private var goFitnessPlanView = false
    @Binding var selectedDate : Date
    @Binding var image1 : String
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter
       }()
    
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
                    
                    VStack (spacing : 16){
                        
                        HStack{
                            Spacer()
                            Text("\(dateFormatter.string(from: $selectedDate.wrappedValue))")
                                .padding(.vertical,8)
                                .font(Font.sentence)
                                .foregroundColor(Color("green_text"))
                            Spacer()
                        }.background(.white)
                        
                        FitnessKgView(weight: $weight)
                        FitnessSetsView(title: "Sets", value: "sets", value2: $sets)
                        FitnessSetsView(title: "Reps", value: "reps", value2: $reps)
                        
                    }.frame(width:360)
                    
                    Spacer()
                    
                    Button(action: {
                        Task{
                            await viewModel.addFitnessRecord(dateOfExercise: selectedDate, name: name, imageName: image1, sets: Int(sets) ?? 0, reps: Int(reps) ?? 0, weight: Int(weight) ?? 0)
                            goFitnessPlanView  = true
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
                    .navigationDestination(isPresented: $goFitnessPlanView) {
                        FitnessPlanView()
                            .environmentObject(AuthViewModel())
                            .navigationBarBackButtonHidden()
                            .onAppear {
                            goFitnessPlanView = false}}
                   
                }
            }
        }
    }
}

struct PlanSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanSettingsView(name: .constant("name"), selectedDate: .constant(Date()), image1: .constant(""))
            .environmentObject(AuthViewModel())
    }
}
