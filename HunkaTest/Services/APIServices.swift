//
//  APIServices.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import Foundation

class APIServices: NSObject {
    
    //delegate is requiered
    weak var delegate : ResponseServicesProtocol?
    
    init(delegate: ResponseServicesProtocol){
        self.delegate = delegate;
        super.init()
    }
    
    //Delegate methods (should be in the delegate ViewController)
    func onSucces(Result : ResultModel, name : ServiceName){
        delegate?.onSucces(result: Result, name: name);
    }
    
    func onError(Error : String, name : ServiceName){
        delegate?.onError(error: Error, name: name);
    }
    
    override init(){
        super.init()
    }

    
    func GETGnomes(){
        
        let URLRequest  = AppConfigurator.APIUrl
        let Client = ServiceRequest.init(delegate: (delegate)!, service :ServiceName.getGnomes);
        
        Client.RequestGET(URLString: URLRequest)
    }
    
}
