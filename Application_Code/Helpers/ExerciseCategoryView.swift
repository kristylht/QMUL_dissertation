//
//  ExerciseCategoryView.swift
//  DietFitFinal
//
//  Created by Kristy on 11/7/2023.
//

import SwiftUI

struct ExerciseCategoryView: View {
    let imagename : String
    let musclename : String
    let navigateTo : String
    
    var body: some View {
        VStack{
            NavigationLink {
                ExerciseListView(selectedMuscles: navigateTo, selectedDate: .constant(Date()))
            } label: {
                VStack{
                    Image(imagename)
                    
                    Text(musclename)
                        .font(Font.answer)
                        .foregroundColor(.black)
                    
                }.background(.white)
                    .cornerRadius(10)
            }
        }.frame(width: 115, height: 145)
    }
    
}

struct ExerciseCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCategoryView(imagename: "core 1", musclename: "core", navigateTo: "chest")
    }
}
