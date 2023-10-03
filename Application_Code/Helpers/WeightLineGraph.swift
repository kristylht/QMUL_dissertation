//
//  WeightLineGraph.swift
//  DietFitFinal
//
//  Created by Kristy on 24/7/2023.
//

import SwiftUI
import Charts 


struct WeightLineGraph: View {
    @StateObject var viewModel = AuthViewModel()
    @State var minYValue : Int = 0
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()
    
    private func fetchWeightRecords() async {
        do {
            try await viewModel.fetchWeightRecords(selectedDate: Date())
        } catch {
            print("Error fetching weight records: \(error)")
        }
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            if !viewModel.weightRecords.isEmpty {
                let minWeight = (viewModel.weightRecords.min(by: { $0.weight < $1.weight })?.weight ?? 0) - 5
                let maxWeight = (viewModel.weightRecords.max(by: { $0.weight < $1.weight })?.weight ?? 0) + 5
                
                Chart { ForEach(viewModel.weightRecords) { item in
                    LineMark(
                        x: .value("Date", dateFormatter.string(from: item.date)),
                        y: .value("Weight", item.weight)
                    )
                }
                }.chartYScale(domain: [minWeight, maxWeight])
                
                    .foregroundColor(Color("green_text"))
                    .frame(height: 300)
                
            } else {
                Text("No weight records found.")
            }
            
            VStack (spacing: 8){
                HStack{
                    Text("Current Weight")
                        .font(Font.sentence)
                        .foregroundColor(Color("green_text"))
                 
                    
                    Spacer()
                    if let latestWeightRecord = viewModel.weightRecords.max(by: { $0.date < $1.date }) {
                        Text("\(latestWeightRecord.weight) kg")
                        
                    } else {
                        Text("- kg")
                    }

                }
                
                HStack{
                    Text("Target Weight")
                        .font(Font.sentence)
                        .foregroundColor(Color("green_text"))
                     
                    
                    
                    Spacer()
                    Text("\(viewModel.currentUser?.targetWeight ?? 0) kg")
                }
                
                HStack{
                    Text("Weight Left")
                        .font(Font.sentence)
                        .foregroundColor(Color("green_text"))
                    
                    Spacer()
                    Text("\(viewModel.weightLeft) kg")                    
                }
            }
        }.task {
            await fetchWeightRecords()
        }
        .padding()
    }
}

struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        WeightLineGraph()
            .environmentObject(AuthViewModel())
    }
}
