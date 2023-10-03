//
//  AddWeightView.swift
//  DietFitFinal
//
//  Created by Kristy on 24/7/2023.
//

import SwiftUI

struct AddWeightView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var selectedDate : Date = Date()
    @State private var weight: String = ""
    @State var goProgressView : Bool  = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:24){
                    Text("Progress")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    VStack(spacing: 16){
                        
                        PlanDateRow(selectedDate: $selectedDate)
                        
                        HStack(spacing: 20) {
                            Text("Weight")
                                .font(.sentence)
                                .foregroundColor(Color("green_text"))
                            
                            Spacer()
                            
                            HStack{
                                TextField("20", text: $weight)
                                    .keyboardType(.numberPad)
                                    .frame(width:45)
                                Text("kg")
                            } .font(.answer)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .frame(height: 40)
                        .background(.white)
                        .cornerRadius(5)
                        
                        Button(action: {
                            Task{
                                viewModel.updateWeight(weight: weight)
                                await viewModel.addUserWeight(date: selectedDate, weight: Int(weight) ?? 0)
                                goProgressView  = true
                            }
                        }) {
                            Text("Confirm")
                                .font(.sentence)
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 360)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("text_background"))
                                )
                        }
                        .navigationDestination(isPresented: $goProgressView) {
                            ProgressView()
                                .environmentObject(AuthViewModel())
                                .navigationBarBackButtonHidden()
                                .onAppear {
                                    goProgressView = false}
                        }
                        Spacer()
                        Spacer()
                    }.frame(width: 360)
                }
            }
        }
    }
}

struct AddWeightView_Previews: PreviewProvider {
    static var previews: some View {
        AddWeightView()
            .environmentObject(AuthViewModel())
    }
}
