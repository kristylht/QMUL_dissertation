//
//  FitnessSetsView.swift
//  DietFitFinal
//
//  Created by Kristy on 27/07/2023.
//

import SwiftUI

struct FitnessSetsView: View {
    let title: String
    let value: String
    @Binding var value2 : String
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.sentence)
                .foregroundColor(Color("green_text"))
            
            Spacer()
            
            HStack{
                TextField("4", text: $value2)
                    .keyboardType(.numberPad)
                    .frame(width:45)
                Text(value)
            } .font(.answer)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(width: 360, height: 30)
        .background(.white)
        .cornerRadius(5)
    }
}
