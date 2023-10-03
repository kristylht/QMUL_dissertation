//
//  DietFitFinalApp.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI

@main
struct DietFitFinalApp: App {
    @EnvironmentObject var viewModel : AuthViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelgate

    var body: some Scene {
        WindowGroup {
           ContentView()
            .environmentObject(AuthViewModel())
        }
    }
}
