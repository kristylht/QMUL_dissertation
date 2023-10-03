//
//  FitnessPlanView.swift
//  DietFitFinal
//
//  Created by Kristy on 12/7/2023.
//

import SwiftUI


struct FitnessPlanView: View {
    @State private var goExerciseList = false
    @State private var selectedDate = Date()
    @EnvironmentObject var viewModel : AuthViewModel
    
    private func fetchFitnessRecords() {
        Task {
            do {
                try await viewModel.fetchFitnessRecords(selectedDate: selectedDate)
            } catch {
                print("Error fetching fitness records: \(error)")
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:24){
                    Text("Your Fitness Plan")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    ScrollView{
                        VStack(spacing:12){
                            PlanDateRow(selectedDate: $selectedDate)
                            
                            
                            ForEach(viewModel.fitnessRecords, id: \.id) { record in
                                FitnessRecord(
                                    recordName: record.name,
                                    recordImage: record.imageName,
                                    recordkg: record.weight,
                                    recordsets: record.sets,
                                    recordreps: record.reps
                                )
                            }
                            
                            VStack {
                                Button {
                                    goExerciseList = true
                                } label: {
                                    Text("+ Add Exercise")
                                        .font(Font.sentence)
                                        .frame(width: 360, height:30)
                                        .background(.white)
                                        .cornerRadius(4)
                                        .foregroundColor(Color("grey_text"))
                                }
                            }
                            .navigationDestination(isPresented: $goExerciseList) {
                                ExerciseListView( selectedDate: $selectedDate).environmentObject(FitnessItemViewModel())}
                            
                        }
                    }.frame(width:360)
                }
            }
        }.onAppear {
            fetchFitnessRecords()
        }
        .onChange(of: selectedDate) { _ in
            fetchFitnessRecords()
        }
    }
}

struct FitnessPlanView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessPlanView()
            .environmentObject(AuthViewModel())
    }
}
