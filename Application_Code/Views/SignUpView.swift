//
//  SignUpPage.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName:String = ""
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var confirmedPassword:String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordRegex.evaluate(with: password)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("background").ignoresSafeArea()
                VStack{
                    //logo
                    Text("DietFit")
                    .frame(maxWidth:.infinity)
                    .font(Font.logo)
                    .foregroundColor(Color("green_text"))
                    .background(.white)
                    
                    Spacer()
                    
                    VStack{
                       
                     Text("Start your journey to health and fitness today.")
                        .font(Font.sentence)
                        .foregroundColor(.black)
                        .lineSpacing(5)
                        .frame(width:196, height: 80)
                        .multilineTextAlignment(.center)
                                          
                     Text("Get started by signing up now")
                        .font(Font.description)
                        .foregroundColor(Color("green_text"))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                         }.padding(2)
                    
                    //enter user info
                    VStack(alignment: .leading, spacing : 10){
                        HStack{ SigninInputView(text: $fullName, title: "Full Name", placeholder: "full name")
                              .autocapitalization(.none)
                                if (fullName.count != 0){
                                  Image(systemName: "checkmark")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("green_text"))
                                    .padding(.top,20)
                                                    }
                                                }
                        
                        HStack{SigninInputView(text: $email, title: "Email", placeholder: "email")
                                .autocapitalization(.none)
                                if (email.count != 0) {
                                   Image(systemName: email.isValidEmail() ?  "checkmark" : "xmark")
                                        .fontWeight(.bold)
                                        .foregroundColor(email.isValidEmail() ? Color("green_text") : .red)
                                        .padding(.top,20)
                                                  }
                                              }
                        
                        HStack{SigninInputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
                                if (password.count != 0) {
                                   Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                                        .fontWeight(.bold)
                                        .foregroundColor(isValidPassword(password) ? Color("green_text") : .red)
                                        .padding(.top,20)
                                                   }
                                               }
                        
                        HStack{SigninInputView(text: $confirmedPassword, title: "Confirmed Password", placeholder: "confirmed password", isSecureField: true)
                               if (isValidPassword(confirmedPassword) && !password.isEmpty) {
                                  if (confirmedPassword == password) { Image(systemName: "checkmark")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("green_text"))
                                            .padding(.top,20)}
                                                 }
                                               }
                    }
                    
                    
                        Button {
                            Task {
                                 try await viewModel.signUp(withEmail:email, password:password, fullname: fullName)
                               
                                  }
                                } label: {
                                Text("Sign up")
                                    .font(Font.sentence)
                                    .frame(width: 300, height:50)
                                    .background(RoundedRectangle(cornerRadius: 4)
                                                .fill(Color("text_background")))
                                            }.foregroundColor(.black)
                                            .padding(8)
                                            .alert(isPresented: $viewModel.showAlert) {
                                                        Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Continue")))
                                                    }
                
                   
                    NavigationLink(destination: LoginView()
                                         .navigationBarBackButtonHidden()) {
                                         HStack{
                                             Text("Already have an account? ")
                                                 .font(Font.description)
                                                 .foregroundColor(.black)
                                             
                                             Text("Log in")
                                                 .font(Font.description)
                                                 .foregroundColor(Color("green_text"))
                                         }
                                     }
                    Spacer()
                    Spacer()
                    
                }
   
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel())

    }
}
