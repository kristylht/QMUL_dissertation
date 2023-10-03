//
//  FitnessView.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI

struct FitnessView: View {
    @State private var selectedTab: Tab = .fitness
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack{
                    Text("Exercises")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    Spacer()
                    
                    VStack(spacing: 12){
                        HStack{
                            ExerciseCategoryView(imagename: "chest 1", musclename: "Chest", navigateTo: "chest")
                            ExerciseCategoryView(imagename: "core 1", musclename: "Abdominals", navigateTo: "abdominals")
                            ExerciseCategoryView(imagename: "shoulder 1", musclename: "Shoulder", navigateTo: "shoulders")
                        }
                        HStack{
                            ExerciseCategoryView(imagename: "triceps 1", musclename: "Trciceps", navigateTo: "triceps")
                            ExerciseCategoryView(imagename: "biceps 1", musclename: "Biceps", navigateTo: "biceps")
                            ExerciseCategoryView(imagename: "forearm 1", musclename: "Forearm", navigateTo: "forearms")
                        }
                        
                        HStack{
                            ExerciseCategoryView(imagename: "upper_leg 1", musclename: "Upper Leg", navigateTo: "upper leg")
                            ExerciseCategoryView(imagename: "lower_leg 1", musclename: "Lower Leg", navigateTo: "lower leg")
                            ExerciseCategoryView(imagename: "glutes 1", musclename: "Glutes", navigateTo: "glutes")
                        }
                        
                        HStack{
                            ExerciseCategoryView(imagename: "back 1", musclename: "Back", navigateTo: "back")
                                .padding(.leading, 20)
                            
                            ExerciseCategoryView(imagename: "cardio 1", musclename: "Cadio", navigateTo: "cardio")
                            
                            Spacer()

                            NavigationLink(destination: FitnessPlanView().environmentObject(AuthViewModel())
                                               ) {
                                   Image(systemName: "plus.circle.fill")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(width: 40, height: 40)
                                       .foregroundColor(Color("green_text"))
                               } .padding(.top, 100)
                                .padding(.trailing, 30)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}


struct FitnessView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessView()
            .environmentObject(FitnessItemViewModel())
    }
}
