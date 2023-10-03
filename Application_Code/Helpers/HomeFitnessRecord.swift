//
//  HomeFitnessRecord.swift
//  DietFitFinal
//
//  Created by Kristy on 24/7/2023.
//

import SwiftUI

struct HomeFitnessRecord: View {
    @State private var goExerciseListView : Bool = false
    @StateObject var viewModel = AuthViewModel ()
    
    private func fetchFitnessRecords() async {
        Task {
            do {
                try await viewModel.fetchFitnessRecords(selectedDate: Date())
            } catch {
                print("Error fetching fitness records: \(error)")
            }
        }
    }
    
    
    var body: some View {
        HStack{
            VStack(alignment:.leading, spacing: 6){
                
                Text("Fitness")
                    .font(Font.sentence)
                    .foregroundColor(Color("green_text"))
                
                if !viewModel.fitnessRecords.isEmpty {
                    ForEach(viewModel.fitnessRecords, id: \.self) { record in
                        HStack{
                            Text("\(record.name)")
                            Spacer()
                            Text("\(record.sets) sets x \(record.reps) reps ")
                        }.padding(.trailing, 16)
                    }
                    
                    Button {
                        goExerciseListView = true
                    } label: {
                        Text("+ Add Exercise")
                            .foregroundColor(Color("grey_text"))
                            .font(Font.sentence)
                    }
                    
                } else {
                    
                    Button {
                        goExerciseListView = true
                    } label: {
                        Text("+ Add Exercise")
                            .foregroundColor(Color("grey_text"))
                            .font(Font.sentence)
                    }
                }
            }
            Spacer()
        }.task {
            await fetchFitnessRecords()
        }
        .frame(width:360)
        .navigationDestination(isPresented: $goExerciseListView) {
            ExerciseListView(selectedDate: .constant(Date()))
                .environmentObject(FitnessItemViewModel())
                .onAppear {
                    goExerciseListView = false}}
    }
}

struct HomeFitnessRecord_Previews: PreviewProvider {
    static var previews: some View {
        HomeFitnessRecord()
            .environmentObject(AuthViewModel())
    }
}
