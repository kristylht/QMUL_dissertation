//
//  CaloriePanel.swift
//  DietFitFinal
//
//  Created by Kristy on 27/07/2023.
//

import SwiftUI

struct CaloriePanel: View {
    var title: String
    var consumed: Int
    var limit: Int
    var minimum : Int
    var unit : String
    var target : Int
    
    private var progress: Double {
        guard limit != 0 else { return 0 }
        return Double(consumed) / Double(limit)
    }
    
    private var minimumCalorie: Double {
        guard minimum != 0 else { return 0 }
        return Double(minimum) / Double(limit)
    }
    
    private var targetDot: Double {
        guard target != 0 else { return 0 }
        return Double(target) / Double(limit)
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color("green_text"))
                Spacer()
                Text(String(consumed) + " / " + String(limit) + " \(unit)")
                    .font(Font.nutrition)
            }
            
            HStack{
                Spacer()
                Text("\(Int(progress*100)) %")
                    .foregroundColor(.gray)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width, height: 8)
                    
                    Rectangle()
                        .foregroundColor(Color("green_text"))
                        .frame(width: min(geometry.size.width, geometry.size.width * CGFloat(progress)), height: 8)
                    
                    Rectangle()
                        .foregroundColor(Color("dot"))
                        .frame(width: 10, height: 8)
                        .position(x: min(geometry.size.width, geometry.size.width * CGFloat(minimumCalorie)), y: 4)
                    
                    
                    Rectangle()
                        .foregroundColor(.yellow)
                        .frame(width: 10, height: 8)
                        .position(x: min(geometry.size.width, geometry.size.width * CGFloat(targetDot)), y: 4)
                }
            }
            VStack{
                if Int(consumed) < Int(minimum){
                    HStack{
                        Spacer()
                        Text("You have not meet the minimum energy requirement")
                            .font(Font.tinyDescription)
                            .foregroundColor(Color("green_text"))
                        Spacer()
                    }
                } else if Int(consumed) > Int(limit){
                    HStack{
                        Spacer()
                        Text("You have exceeded your daily limit ")
                            .font(Font.tinyDescription)
                            .foregroundColor(Color("green_text"))
                        Spacer()
                    }
                } else {
                    HStack{
                        Spacer()
                        Text("You are in the right range!")
                            .font(Font.tinyDescription)
                            .foregroundColor(Color("green_text"))
                        Spacer()
                    }
                    
                }
            }.padding(.top,12)
        }.padding([.leading, .trailing])
            .frame(height:50)
    }
}
