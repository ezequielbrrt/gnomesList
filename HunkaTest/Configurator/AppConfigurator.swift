//
//  AppConfigurator.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import Foundation

class AppConfigurator: NSObject{
    
    //API
    static let APIUrl : String = "https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json"
    
    static let mainColor = Tools.RGB(r: 38, g: 56, b: 72)
    static let secondaryColor = Tools.RGB(r: 240, g: 24, b: 115)
    
    static let mainColorString = "263848"
    static let mainBackgroundColorString = "efeef4"
    static let mainColorGradientString = "f2a49f"
    
    //Fonts -----------------------------------------------------------------
    static let fontLight = "Cinzel-Regular"
    static let fontRegular = "Cinzel-Regular"
    static let fontBold = "Cinzel-Bold"
    static let fontItalic = "Cinzel-Black"
    
    // MARK: Amazon s3
    static let urlSecondsChache = 3600
    
}

