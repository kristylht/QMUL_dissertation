//
//  HomeView.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = AuthViewModel()
    private var showAlert : Binding<Bool> {
        if viewModel.targetCalorie < viewModel.BMR {
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
                
                VStack(spacing:24){
                    Text("Home")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    ScrollView{
                        VStack (spacing: 8){
                            
                            HomeAddFoodRow()
                            
                            HomeFitnessRecord()
                                .padding(.leading, 30)
                                .padding(8)
                                .frame(width:360)
                                .background(Color.white)
                                .cornerRadius(5)
                        }
                    }
                }.alert(isPresented: showAlert, content: {
                    Alert(title: Text("Warning"),
                          message: Text("It is recommended to consume more than your BMR"),
                          dismissButton: .default(Text("OK")))
                })
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}


