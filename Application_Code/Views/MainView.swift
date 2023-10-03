//
//  MainView.swift
//  DietFitFinal
//
//  Created by Kristy on 3/7/2023.
//

import SwiftUI

enum Tab {
    case fitness
    case diet
    case home
    case progress
    case settings
}

struct MainView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @Binding var selectedTab: Tab
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            FitnessView()
                .environmentObject(FitnessItemViewModel())
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Fitness")
                }.tag(Tab.fitness)
            
            DietView(selectedDate: .constant(Date()), typeOfDiet: .constant("Breakfast"))
                .environmentObject(FoodItemViewModel())
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Diet")
                }.tag(Tab.diet)
            
            HomeView().environmentObject(AuthViewModel())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(Tab.home)
            
            ProgressView().environmentObject(AuthViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Progress")
                }.tag(Tab.progress)
            
            SettingsView().environmentObject(AuthViewModel())
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                } .tag(Tab.settings)
            
        }.accentColor(Color("green_text"))
            .onAppear() {
                UITabBar.appearance().backgroundColor = .white
                selectedTab = .home
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedTab: .constant(.home))
            .environmentObject(AuthViewModel())
    }
}
