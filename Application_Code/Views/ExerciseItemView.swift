//
//  ExerciseItemView.swift
//  DietFitFinal
//
//  Created by Kristy on 14/7/2023.
//

import SwiftUI

struct ExerciseItemView: View {
    @State var name : String
    @State var image1 : String
    let image2 : String
    let level : String
    let primaryMuscles : String
    let instructions : [String]
    @State private var goPlanSettingsView = false
    @Binding var selectedDate: Date

    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:8){
                    Text(name)
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    ScrollView{
                        HStack{
                            LoadedImage(recordImage: image1 )
                            LoadedImage(recordImage: image2 )
                        }.padding(.horizontal, 20)
                            .padding(.bottom, 12)
                        
                        VStack(spacing:24){

                            InfoView(title: "Level", value: level)
                            InfoView(title: "Primary Muscles", value: primaryMuscles)
                            
                            
                                VStack(alignment:.leading, spacing: 4) {
                                    Text("Instructions")
                                        .font(.sentence)
                                        .foregroundColor(Color("green_text"))
                                    
                                    ForEach(instructions, id: \.self) { instruction in
                                        Text(instruction)
                                            .font(.answer)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }.padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(.white)
                                    .cornerRadius(5)
                                    .frame(width:360)
                          
                            Button{
                                goPlanSettingsView = true
                            } label: {
                                Text("+ Add to Your Fitness Plan")
                                    .font(.sentence)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 360)
                                    .background(Color("text_background"))
                                    .cornerRadius(5)
                            }
                            .navigationDestination(isPresented: $goPlanSettingsView) {
                                PlanSettingsView(name: $name, selectedDate: $selectedDate, image1: $image1).environmentObject(AuthViewModel())}
                           
                        }.frame(width:360)
                        Spacer()
                    }
                }
            }
        } 
    }
}


struct ExerciseItemView_Previews: PreviewProvider {
    static var previews: some View {   
        ExerciseItemView(name: "Seated Leg Tucks", image1: "Seated_Leg_Tucks0.jpg", image2:"Seated_Leg_Tucks1.jpg" , level: "beginner", primaryMuscles: "abdominals", instructions: ["Sit on a bench with the legs stretched out in front of you slightly below parallel and your arms holding on to the sides of the bench. Your torso should be leaning backwards around a 45-degree angle from the bench. This will be your starting position.",
                         "Bring the knees in toward you as you move your torso closer to them at the same time. Breathe out as you perform this movement.",
                         "After a second pause, go back to the starting position as you inhale.", "Repeat for the recommended amount of repetitions."], selectedDate: .constant(Date()))
    }
}

