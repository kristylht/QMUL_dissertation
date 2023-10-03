//
//  PlanDateRow.swift
//  DietFitFinal
//
//  Created by Kristy on 12/7/2023.
//

import SwiftUI

struct PlanDateRow: View {
    @Binding var selectedDate: Date
    @State private var isDatePickerShown = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter
    }()
    
    var body: some View {
        Button(action: {
            isDatePickerShown.toggle()
        }) {
            if isDatePickerShown {
                VStack{
                    HStack{
                        Spacer()
                        Text("<\(dateFormatter.string(from: selectedDate))>")
                        Spacer()
                    }.foregroundColor(Color("green_text"))
                        .font(Font.sentence)
                        .padding(.vertical, 5)
                        .background(.white)
                        .cornerRadius(5)
                    
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .accentColor(Color("green_text"))
                        .background(.white)
                        .frame(width:200, height: 280)
                        .padding(10)
                }
            } else {
                HStack{
                    Spacer()
                    Text("<\(dateFormatter.string(from: selectedDate))>")
                    Spacer()
                } .foregroundColor(Color("green_text"))
                    .font(Font.sentence)
                    .padding(.vertical, 5)
                    .background(.white)
                .cornerRadius(5)}
        }
    }
}

struct PlanDateRow_Previews: PreviewProvider {
    static var previews: some View {
        PlanDateRow(selectedDate: .constant(Date()))
    }
}
