//
//  ResultModel.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import Foundation

class ResultModel: NSObject
{
    var env : String?
    var success : Bool?
    var content : Any?
    var generated : String?
    var api_version : String?
    var code : Int?
    
    func toString() -> String
    {
        let SEnv : String = "env :" + env! + "\n"
        let SSucces : String = "success :" + String(success!) + "\n"
        let SContent : String = "content :" + String(describing: content!)
        let SGenerate : String = "generated :" + generated! + "\n"
        let SApi : String =  "api_version :" + api_version!  + "\n"
        let all : String = SEnv + SSucces + SGenerate + SApi + SContent
        return all;
    }
}

