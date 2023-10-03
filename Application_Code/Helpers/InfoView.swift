//
//  InfoView.swift
//  DietFitFinal
//
//  Created by Kristy on 27/07/2023.
//

import SwiftUI

struct InfoView: View {
    let title: String
    let value: String
    
    var body: some View {
            HStack(spacing: 20) {
                Text(title)
                    .font(.sentence)
                    .foregroundColor(Color("green_text"))
                
                Spacer()
                
                Text(value)
                    .font(.answer)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.white)
            .cornerRadius(5)
            .frame(width:360, height: 20)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(title: "some title", value: "some value")
    }
}
