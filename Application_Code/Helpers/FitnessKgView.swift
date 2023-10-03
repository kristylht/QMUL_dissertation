//
//  FitnessKgView.swift
//  DietFitFinal
//
//  Created by Kristy on 27/07/2023.
//

import SwiftUI

struct FitnessKgView: View {
    @Binding var weight : String
    
    var body: some View {
        HStack(spacing: 20) {
            Text("Weight")
                .font(.sentence)
                .foregroundColor(Color("green_text"))
            
            Spacer()
            
            HStack{
                TextField("60", text: $weight)
                    .keyboardType(.numberPad)
                    .frame(width:45)
                Text("kg")
            } .font(.answer)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(width: 360, height:30)
        .background(.white)
        .cornerRadius(5)
    }
}


