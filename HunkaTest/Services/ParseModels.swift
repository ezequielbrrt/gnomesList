//
//  ParseModels.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import Foundation

class ParseModels: NSObject{
    
    class func parseGnomes(result: ResultModel) -> [Gnome]{
        
        let resutlDictionaryAux : NSDictionary = result.content as! NSDictionary
        let resutlDictionary : [NSDictionary] = resutlDictionaryAux.object(forKey: "Brastlewark") as! [NSDictionary]
        
        var gnomes = [Gnome]()
        
        resutlDictionary.forEach{ item in
            
            let gnome = Gnome()
            gnome.id = item.object(forKey: "id") as? Int
            gnome.name = item.object(forKey: "name") as? String
            gnome.thumbnail = item.object(forKey: "thumbnail") as? String
            gnome.age = item.object(forKey: "age") as? Int
            gnome.weight = item.object(forKey: "weight") as? Double
            gnome.height = item.object(forKey: "height") as? Double
            gnome.hair_color = item.object(forKey: "hair_color") as? String
            gnome.professions = item.object(forKey: "professions") as? [String]
            gnome.friends = item.object(forKey: "friends") as? [String]
            
            let randomBool = Bool.random()
            if randomBool{
                gnome.gender = "M"
            }else{
                gnome.gender = "H"
            }
            
            
            gnomes.append(gnome)
        }
        
        return gnomes
        
    }

}

