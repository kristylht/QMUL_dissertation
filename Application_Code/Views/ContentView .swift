//
//  ContentView .swift
//  DietFitFinal
//
//  Created by Kristy on 3/7/2023.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        
        Group{
            if viewModel.userSession != nil && viewModel.showGoalView == true {
                GoalView()}
            else if viewModel.userSession != nil && viewModel.showGoalView == false {
                MainView(selectedTab: .constant(.home))
            } else
                {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
