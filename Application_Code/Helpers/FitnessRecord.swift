//
//  FitnessRecord.swift
//  DietFitFinal
//
//  Created by Kristy on 13/7/2023.
//

import SwiftUI

struct FitnessRecord: View {
    public var recordName: String
    public var recordImage: String
    public var recordkg: Int
    public var recordsets: Int
    public var recordreps: Int
    
    var body: some View {
        HStack {
            LoadedImage(recordImage: recordImage)
                .padding(.trailing,10)
                .padding(.leading,20)
                .alignmentGuide(.leading) { _ in 0 }
            
            VStack(alignment: .leading, spacing: 4){
                Text(recordName)
                Text("\(recordkg) kg, \(recordsets) sets,\(recordreps) reps" )
                    .foregroundColor(Color("grey_text"))
            }.font(.answer)
                .padding(.trailing, 30)
            
            Spacer()
            
        }.frame(width:360, height: 100)
            .background(.white)
            .cornerRadius(5)
    }
}

struct FitnessRecord_Previews: PreviewProvider {
    static var previews: some View {
        FitnessRecord(recordName: "Seated Dumbbell Inner Biceps Curl", recordImage:  "3_4_Sit_Up0.jpg", recordkg: 4, recordsets: 4, recordreps: 4)
    }
}


