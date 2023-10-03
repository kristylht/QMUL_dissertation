//
//  MacroNutrientPanel.swift
//  DietFitFinal
//
//  Created by Kristy on 27/07/2023.
//

import SwiftUI

struct MacroNutrientPanel: View {
    var title: String
    var consumed: Int
    var limit: Int
    var unit : String
    
    private var progress: Double {
        guard limit != 0 else { return 0 }
        return Double(consumed) / Double(limit)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("green_text"))
                Spacer()
                Text("\(consumed) / \(limit) \(unit)")
                    .font(Font.nutrition)
            }
            
            HStack{
                Spacer()
                Text("\(Int(progress*100)) %")
                    .foregroundColor(.gray)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width, height: 8)
                    
                    Rectangle()
                        .foregroundColor(Color("green_text"))
                        .frame(width: min(geometry.size.width, geometry.size.width * CGFloat(progress)), height: 8)
                }
            }
        }.padding([.leading, .trailing])
    }
}
