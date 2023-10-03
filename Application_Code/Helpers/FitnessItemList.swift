//
//  FitnessItemList.swift
//  DietFitFinal
//
//  Created by Kristy on 14/7/2023.
//

import SwiftUI

struct FitnessItemList: View {
    public var recordName: String
    public var recordImage: String
    
    var body: some View {
        HStack {
            LoadedImage(recordImage: recordImage)
                .padding(.trailing,10)
                .padding(.leading,20)
                .alignmentGuide(.leading) { _ in 0 }
            
            Text(recordName)
                .font(.answer)
                .padding(.trailing, 30)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
        }.frame(width:360, height: 80)
    }
}

struct FitnessItemList_Previews: PreviewProvider {
    static var previews: some View {
        FitnessItemList(recordName: "Sample Sample  Sample Sample Sample", recordImage:  "3_4_Sit_Up0.jpg")
    }
}
