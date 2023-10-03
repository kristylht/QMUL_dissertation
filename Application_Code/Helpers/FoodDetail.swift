//
//  FoodDetail.swift
//  DietFitFinal
//
//  Created by Kristy on 19/7/2023.
//

import SwiftUI

struct FoodDetail: View {
    var title: String
    var value: Any
    var unit : String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading,16)
                .foregroundColor(Color("green_text"))
                .font(Font.sentence)
            
            Spacer()
            
            HStack(spacing:4){
                if value is Int {
                    Text(""+"\(value)")
                } else if value is Double {
                    Text(String(format: "%.2f", value as! CVarArg))
                }
                
                Text(unit)
                
            }.font(.answer)
                .padding(.trailing, 16)
            
        }.frame(width:360, height: 40)
        .background(.white)
        .cornerRadius(5)
    }
}


struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(title: "Energy", value: 100.234, unit: "kcal")
    }
}
