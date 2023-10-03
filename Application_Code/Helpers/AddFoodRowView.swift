//
//  AddFoodRowView.swift
//  DietFitFinal
//
//  Created by Kristy on 19/7/2023.
//

import SwiftUI

struct AddFoodRowView: View {
    var title: String
    @Binding var selectedDate: Date
    @State var typeOfDiet : String
    @State private var goDietView : Bool = false
    @Binding var records: [EachDietRecord]
    @EnvironmentObject var viewModel : AuthViewModel
    
    
    var body: some View {
        HStack{
            VStack(alignment:.leading, spacing: 4){
                
                Text(title)
                    .foregroundColor(Color("green_text"))
                    .font(Font.sentence)
                
                if records != [] {
                    ForEach($records, id: \.self) { record in
                        DietRecordRow(name: record.name, calories: record.calories)
                    }
                    
                    Button {
                        typeOfDiet = typeOfDiet
                        goDietView = true
                    } label: {
                        Text("+ Add Food")
                            .foregroundColor(Color("grey_text"))
                            .font(Font.sentence)
                    }
                    
                } else {
                    
                    Button {
                        typeOfDiet = typeOfDiet
                        goDietView = true
                    } label: {
                        Text("+ Add Food")
                            .foregroundColor(Color("grey_text"))
                            .font(Font.sentence)
                    }
                }
                
            }.padding(8)
                .padding(.leading, 8)
            Spacer()
        }.frame(width:360)
        .background(.white)
        .cornerRadius(5)
        .navigationDestination(isPresented: $goDietView) {
            DietView(selectedDate: $selectedDate, typeOfDiet: $typeOfDiet)
                .environmentObject(FoodItemViewModel())
                .onAppear {
                    goDietView = false}}
    }
}

struct AddFoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodRowView(title: "Breakfast", selectedDate: .constant(Date()), typeOfDiet: "Breakfast", records: .constant([]))
            .environmentObject(AuthViewModel())
    }
}
