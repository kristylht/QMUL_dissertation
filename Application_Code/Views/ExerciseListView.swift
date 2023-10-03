//
//  ExerciseListView.swift
//  DietFitFinal
//
//  Created by Kristy on 13/7/2023.
//

import SwiftUI

struct ExerciseListView: View {
    @EnvironmentObject var viewModel : FitnessItemViewModel
    @State public var selectedMuscles: String?
    @State public var selectedLevel: String?
    @State public var searchText : String = ""
    @Binding var selectedDate: Date
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .ignoresSafeArea()
                
                VStack(spacing:24){
                    Text("Exercises")
                        .padding([.bottom],10)
                        .frame(maxWidth:.infinity)
                        .font(Font.signInTitle)
                        .foregroundColor(.black)
                        .background(.white)
                    
                    VStack (spacing: 12) {
                        VStack (spacing: 12){
                            
                            TextField("Search", text: $searchText)
                                .padding(.horizontal, 32)
                                .frame(height: 40)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("green_text"), lineWidth: 1))
                                .cornerRadius(8)
                                .frame(width:370)
                                .onChange(of: searchText) { newValue in
                                    viewModel.filterItems(searchText: newValue)
                                }
                            
                            HStack {
                                Menu() {
                                    Group{
                                        Button("Chest") {
                                            Task{
                                                selectedMuscles = "chest"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel)
                                            }}
                                        
                                        Button("Abdominals"){
                                            Task{
                                                selectedMuscles = "abdominals"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        
                                        Button("Shoulder"){
                                            Task{
                                                selectedMuscles = "shoulders"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Triceps"){
                                            Task{
                                                selectedMuscles = "triceps"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Biceps"){
                                            Task{
                                                selectedMuscles = "biceps"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Forearms"){
                                            Task{
                                                selectedMuscles = "forearms"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Upper Leg"){
                                            Task{
                                                selectedMuscles = "upper leg"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Lower Leg"){
                                            Task{
                                                selectedMuscles = "lower leg"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Glutes"){
                                            Task{
                                                selectedMuscles = "glutes"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                        Button("Back"){
                                            Task{
                                                selectedMuscles = "back"
                                                viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}}
                                    
                                    Button("Cardio"){
                                        Task{
                                            selectedMuscles = "cardio"
                                            viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                    
                                    Button (role:.destructive) {
                                        selectedMuscles = nil
                                        viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel)
                                    } label: {
                                        Text("Clear")
                                    }
                                    
                                } label: {
                                    Label("Muscles", systemImage: "arrowtriangle.down")
                                        .foregroundColor(Color("green_text"))
                                        .frame(width: 180, height: 25)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundColor(.white) )
                                }
                                
                                Menu() {
                                    Button("Beginner"){
                                        Task{
                                            selectedLevel = "beginner"
                                            viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                    Button("Intermediate"){
                                        Task{
                                            selectedLevel = "intermediate"
                                            viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                    Button("Expert"){
                                        Task{
                                            selectedLevel = "expert"
                                            viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel) }}
                                    Button (role:.destructive) {
                                        selectedLevel = nil
                                        viewModel.filterItems(selectedMuscle: selectedMuscles, selectedLevel: selectedLevel)
                                    } label: {
                                        Text("Clear")
                                    }
                                } label: {
                                    Label("Level", systemImage: "arrowtriangle.down")
                                        .foregroundColor(Color("green_text"))
                                        .frame(width: 180, height: 25)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .foregroundColor(.white) )
                                }
                            }
                        }
                        
                        if viewModel.filteredFitnessItems.isEmpty {
                            Text("Opps, there is no exercises")
                                .foregroundColor(Color("green_text"))
                                .padding(.top, 20)
                        } else {
                            ScrollView{
                                ForEach(viewModel.filteredFitnessItems) { item in
                                    NavigationLink(destination: ExerciseItemView(name: item.name, image1: "\(item.images[0]).jpg", image2: "\(item.images[1]).jpg", level: item.level, primaryMuscles: item.primaryMuscles[0], instructions: item.instructions, selectedDate: $selectedDate)) {
                                        
                                        FitnessItemList(recordName: item.name, recordImage: "\(item.images[0]).jpg")
                                            .foregroundColor(.black)
                                            .background(.white)
                                        
                                    }
                                }.cornerRadius(5)
                            }.listStyle(.plain)
                        }
                    }.frame(width:360)
                }
            } .onAppear {
                viewModel.filterItems(selectedMuscle: selectedMuscles)
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(selectedDate: .constant(Date()))
            .environmentObject(FitnessItemViewModel())
    }
}

