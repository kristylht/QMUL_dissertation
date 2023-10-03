//
//  SettingsView.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI
import Foundation

struct SettingsView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var infoIsEditing: Bool = false
    @State private var goalIsEditing: Bool = false
    @State private var height: Int = 22
    @State private var newHeight: String = ""
    @State private var newTargetWeight: String = ""
    @State private var newTargetDate: Date = Date()
    @State private var refreshID: UUID = UUID()
    
    private func formattedDate(dateData: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy"
        return formatter.string(from: dateData)
    }
    
    var body: some View {
        VStack{
            if let user = viewModel.currentUser {
                ZStack{
                    Color("background")
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        HStack{ Text("Settings")
                                .padding([.bottom],10)
                                .frame(maxWidth:.infinity)
                                .font(Font.signInTitle)
                                .foregroundColor(.black)
                                .background(.white)
                        }
                        
                        List{
                            Section{
                                VStack(alignment: .leading,spacing: 4){
                                    Text(user.fullname)
                                        .font(Font.alertTitle)
                                        .padding(.top, 4)
                                    
                                    Text(user.email)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Section(header: HStack{Text("Information")
                                Spacer()
                                Text("Edit")
                                    .foregroundColor(Color("green_text"))
                                    .onTapGesture {infoIsEditing.toggle()}
                            })
                            {
                                HStack{
                                    Text ("Gender")
                                    Spacer()
                                    Text ("\(user.gender)")
                                        .foregroundColor(.black)
                                }
                                
                                HStack{
                                    Text ("Date of Birth")
                                    Spacer()
                                    Text(formattedDate(dateData:user.dateOfBirth))
                                        .foregroundColor(.black)
                                }
                                
                                HStack{
                                    Text ("Height")
                                    Spacer()
                                    if infoIsEditing {
                                        TextField( "Click", text: $newHeight)
                                            .foregroundColor(.gray)
                                            .keyboardType(.numberPad)
                                            .frame(width: 70)
                                    }
                                    else {
                                        Text("\(user.height)")
                                        .foregroundColor(.black)}
                                    Text ("cm") .foregroundColor(.black)
                                }
                            }
                        }.frame(height:300)
                        
                        if infoIsEditing{
                            Button {
                                Task{
                                    infoIsEditing = false
                                    viewModel.updateHeight(height: newHeight)
                                    await viewModel.fetchUserData()}
                            } label: {
                                Text("Confirm")
                                    .font(Font.sentence)
                                    .frame(width: 300, height:50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color("text_background"))
                                    )
                                    .foregroundColor(.black)
                                    .padding(8)
                            }
                        }
                        
                        List{
                            Section (header: HStack{Text("Goals")
                                Spacer()
                                Text("Edit")
                                    .foregroundColor(Color("green_text"))
                                    .onTapGesture {goalIsEditing.toggle()}
                            }){
                                HStack{
                                    Text ("Target Weight")
                                    Spacer()
                                    if goalIsEditing {
                                        TextField( "Click", text: $newTargetWeight)
                                            .foregroundColor(.gray)
                                            .keyboardType(.numberPad)
                                            .frame(width: 70)
                                    }
                                    else {
                                        Text("\(user.targetWeight)")
                                        .foregroundColor(.black)}
                                    Text ("kg") .foregroundColor(.black)
                                }
                                
                                HStack{
                                    if goalIsEditing {
                                        DatePicker(selection: $newTargetDate, in: Date.now..., displayedComponents: .date) {
                                            Text("Target Date")
                                        }
                                    }
                                    else {
                                        Text ("Target Date")
                                        Spacer()
                                        Text(formattedDate(dateData:user.targetDate))
                                        .foregroundColor(.black)}
                                }
                            }}.frame(height: 140)
                        
                        if goalIsEditing{
                            Button {
                                Task{
                                    goalIsEditing = false
                                    viewModel.updateTargetWeight(targetWeight: newTargetWeight)
                                    viewModel.updateTargetDate(targetDate: newTargetDate)
                                    await viewModel.fetchUserData()}
                            } label: {
                                Text("Confirm")
                                    .font(Font.sentence)
                                    .frame(width: 300, height:50)
                                    .background(Color("text_background"))
                                    .cornerRadius(4)
                                    .foregroundColor(.black)
                                    .padding(8)
                            }
                        }
                        
                        List{
                            Section ("Account"){
                                // account
                                Button {
                                    // sign out
                                    viewModel.signOut()
                                } label: {
                                    Text ("Sign Out")
                                        .foregroundColor(.black)
                                }
                                
                                Button {
                                    viewModel.deleteAccount()
                                    
                                } label: {
                                    Text ("Delete Account ")
                                        .foregroundColor(.red)
                                }
                            }
                        }.listStyle(.insetGrouped)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
    }
}
