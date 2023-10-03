//
//  SigninInputView.swift
//  DietFitFinal
//
//  Created by Kristy on 1/7/2023.
//

import SwiftUI

struct SigninInputView: View {
    @Binding var text : String
    let title : String
    let placeholder : String
    var isSecureField = false

    var body: some View {
        VStack(alignment: .leading, spacing : 2){
            Text(title)
                .font(Font.tinyDescription)
            
            if isSecureField {

                    SecureField(placeholder, text: $text)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(lineWidth: 1.5))
                            .background(Color(.white))
              
            }
            else {
                    TextField(placeholder, text: $text)
                        .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1.5))
                        .background(Color(.white))
            }
        }.frame(width: 300)
    }
}

struct SigninInputView_Previews: PreviewProvider {
    static var previews: some View {
        SigninInputView(text: .constant(""), title: "username", placeholder: "kristy")
    }
}
