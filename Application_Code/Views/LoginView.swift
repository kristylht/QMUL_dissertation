//
//  LoginView.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var email:String = ""
    @State private var password:String = ""
   
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("background")
                    .ignoresSafeArea()

                VStack{
                    HStack{ Text("Log In")
                            .padding([.bottom],10)
                            .frame(maxWidth:.infinity)
                            .font(Font.signInTitle)
                            .foregroundColor(.black)
                            .background(.white)
                    }
                    
                    Spacer()
                    
                    //captions
                    VStack{
                        
                        Text("Continue your journey to health and fitness today.")
                            .font(Font.sentence)
                            .foregroundColor(.black)
                            .lineSpacing(5)
                            .frame(width:196, height: 80)
                            .multilineTextAlignment(.center)
                        
                    }.padding(2)
                    
                    //enter sign up details
                    VStack(alignment: .leading, spacing : 10){
                        
                       
                            SigninInputView(text: $email, title: "Email", placeholder: "email")
                                .autocapitalization(.none)
                            
                            SigninInputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
                        
                    }
                    
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }

                    } label: {
                    
                            Text("Login")
                                .font(Font.sentence)
                                .frame(width: 300, height:50)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color("text_background"))
                                )
                                .foregroundColor(.black)
                                .padding(8)
                        
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Continue")))
                            }

                    // don't have account
                    
                    NavigationLink(destination: SignUpView()
                        .navigationBarBackButtonHidden()) {
                            HStack{
                                Text("Don't have an account? ")
                                    .font(Font.description)
                                    .foregroundColor(.black)
                                
                                Text("Sign up")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())

    }
}
