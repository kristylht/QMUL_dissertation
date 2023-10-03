//
//  Font.swift
//  DietFitFinal
//
//  Created by Kristy on 30/6/2023.
//

import Foundation
import SwiftUI

extension Font {
    
    public static var logo: Font {
        return Font.custom("SFPro-Bold", size: 48)
    }
    
    public static var singUp: Font {
        return Font.custom("SFPro-Bold", size: 28)
    }
    
    public static var button: Font {
        return Font.custom("SFPro-Bold", size: 11)
    }
    
    public static var signInTitle: Font {
        return Font.custom("SFPro-Bold", size: 22)
    }
    
    public static var sentence: Font {
        return Font.custom("SFPro-Semibold", size: 17)
    }
    
    public static var menu: Font {
        return Font.custom("SFPro-Semibold", size: 10)
    }
    
    public static var alertTitle: Font {
        return Font.custom("SFPro-Semibold", size: 20)
    }
    
    public static var nutrition: Font {
        return Font.custom("SFPro-Semibold", size: 15)
    }
    
    public static var addButton: Font {
        return Font.custom("SFPro-Semibold", size: 16)
    }
    
    public static var description: Font {
        return Font.custom("SFPro-Regular", size: 15)
    }
  
    public static var tinyDescription: Font {
        return Font.custom("SFPro-Regular", size: 11)
    }

    public static var answer: Font {
        return Font.custom("SFPro-Regular", size: 17)
    }

    public static var percentage: Font {
        return Font.custom("SFPro-Regular", size: 13)
    }

    public static var item: Font {
        return Font.custom("SFPro-Regular", size: 16)
    }

}
