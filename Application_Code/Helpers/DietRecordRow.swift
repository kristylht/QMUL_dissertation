//
//  DietRecordRow.swift
//  DietFitFinal
//
//  Created by Kristy on 23/7/2023.
//

import SwiftUI

struct DietRecordRow: View {
    @Binding var name : String
    @Binding var calories : Int
    
    var body: some View {
        HStack{
            Text(name)
                .font(Font.item)
           
            Spacer()
            
            Text("\(calories)")
                .font(Font.item)
            Text("kcal")
        }
    }
}

struct DietRecordRow_Previews: PreviewProvider {
    static var previews: some View {
        DietRecordRow(name: .constant("some food"), calories: .constant(20))
    }
}
