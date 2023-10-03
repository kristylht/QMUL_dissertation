//
//  ProgressView.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI

struct ProgressView: View {
    @StateObject var viewModel = AuthViewModel()
    @State var goAddWeightView : Bool  = false
    @State var selectedDate : Date = Date()
    @State private var goHistoryView = false
    @State private var selectedTab: Tab = .progress
    
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
                    
                    ScrollView(){
                        VStack (spacing:16){
                            VStack{
                                HStack{
                                    Text("Weight")
                                        .foregroundColor(Color("green_text"))
                                        .font(Font.sentence)
                                    
                                    Spacer()
                                    
                                    
                                    NavigationLink(destination: AddWeightView().environmentObject(AuthViewModel())
                                    ) {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color("green_text"))
                                    }
                                }.padding(.horizontal, 16)
                                    .padding(.top, 12)
                                
                                WeightLineGraph()
                                

                            } .background(.white)
                                .cornerRadius(5)
                                .frame(width: 360)
                            
                            
                            HStack{
                                Spacer()
                                Text("History")
                                    .font(Font.sentence)
                                    .padding(8)
                                Spacer()
                            }.background(Color("text_background"))
                                .cornerRadius(5)
                                .frame(width: 360)
                            
                            
                            DatePicker(
                                "Select a Date",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .background(.white)
                            .cornerRadius(5)
                            .frame(width: 360)
                            .onChange(of: selectedDate) { newValue in
                                goHistoryView = true
                                print(selectedDate)
                            }.navigationDestination(isPresented: $goHistoryView) {
                                HistoryView(selectedDate: selectedDate)
                                    .environmentObject(AuthViewModel())
                                    .onAppear {
                                        goHistoryView = false}
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(AuthViewModel())
    }
}
