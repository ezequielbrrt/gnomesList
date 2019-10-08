//
//  session.swift
//  boilerplate_ios
//
//  Created by Ezequiel Barreto on 7/19/19.
//  Copyright © 2019 Ezequiel Barreto All rights reserved.
//


import UIKit

class session: NSObject
{
    
    private override init() { }
    
    // Shared Instance
    static let shared = session()
    
    
    var gnomes: [Gnome]?
    var firstId: Int?
    var nextId: Int?
    var lastId: Int?
    
    // Validation variables
    var orderByName: Bool = false
    var filterColorHair: String?
    var minWeight: Double?
    var maxWeight: Double?
    var minHeight: Double?
    var maxHeight: Double?
    var minAge: Int?
    var maxAge: Int?
    var filterProfessions = [String]()
    
    public func clearFilters(){
        
        self.orderByName = false
        self.filterColorHair = nil
        self.minWeight = nil
        self.maxWeight = nil
        self.minHeight = nil
        self.maxHeight = nil
        self.minAge = nil
        self.maxAge = nil
        self.filterProfessions = []
    }
    
}

