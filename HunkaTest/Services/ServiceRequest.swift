//
//  ServiceRequest.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

//Requiered Protocl methods
protocol ResponseServicesProtocol: class
{
    func onSucces(result : ResultModel, name : ServiceName)
    
    func onError(error : String, name : ServiceName)
}

class ServiceRequest: NSObject{
    
    weak var delegate : ResponseServicesProtocol?
    weak var controller : UIViewController?
    var currentService : ServiceName?
    var timer : Timer?
    var seconds : Int?
    var requestDone = false
    
    static var SECONDS_TO_SHOW_SLOW_CONNECTION = 6
    
    override init()
    {
        super.init()
    }
    
    init(delegate: ResponseServicesProtocol, service : ServiceName)
    {
        self.delegate = delegate;
        self.currentService = service
        self.controller = delegate as? UIViewController
        super.init()
    }
    
    //GET Method
    func RequestGET(URLString : String)
    {
        print("\n")
        print("Request(GET) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "GET"
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
    }
    
    //POST Method
    func RequestPOST(Parameters : NSDictionary, URLString : String)
    {
        print("\n")
        print("Request(POST) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "POST"
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters)!
            
            print("with Body:\n"+postString!)
            
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    //POST Method NO Token
    func RequestPOSTWithContentType(Parameters : NSDictionary, URLString : String)
    {
        print("\n")
        print("Request(POST) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "POST"
        
        Request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters)!
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    
    
    func RequestPOSTwithAny(Parameters :  [[String: String]], URLString : String, showAlertConnection: Bool = false){
        
        print("\n")
        print("Request(POST) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "POST"
        
        let token : String? = UserDefaults.standard.object(forKey: "token") as? String
        print("AuthToken:  " + token!)
        
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters as AnyObject)!
            
            print("with Body:\n"+postString!)
            
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            if showAlertConnection{
                self.delegate?.onError(error:"conexion", name : self.currentService!)
            }else{
                notInternetAlert()
            }
            
        }
        
    }
    
    //POST Method with Token
    func RequestPOSTWithAutorization(Parameters : NSDictionary, URLString : String, showAlertConnection: Bool = false)
    {
        print("\n")
        print("Request(POST) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "POST"
        
        let token : String? = UserDefaults.standard.object(forKey: "token") as? String
        print("AuthToken:  " + token!)
        
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters)!
            
            print("with Body:\n"+postString!)
            
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            if showAlertConnection{
                self.delegate?.onError(error:"conexion", name : self.currentService!)
            }else{
                notInternetAlert()
            }
            
        }
        
    }
    
    //POST GET with Token
    func RequestGETWithAutorization(URLString : String, showAlertConnection: Bool = false)
    {
        print("\n")
        print("Request(GET) " + URLString);
        
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "GET"
        
        let token : String? = UserDefaults.standard.object(forKey: "token") as? String
        if token == nil
        {
            return
        }
        
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        
        let postString : String? = "";
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            if showAlertConnection{
                self.delegate?.onError(error:"conexion", name : self.currentService!)
            }else{
                notInternetAlert()
            }
        }
        
    }
    
    
    //POST Method with URL encode
    func RequestPOSTWithURLEncode(URLString : String)
    {
        print("\n")
        print("Request(POST) " + URLString);
        
        var Request = URLRequest(url: URL(string: URLString)!)
        
        Request.httpMethod = "POST"
        let postString = "grant_type=password&username=Em&password=beberaton&platform=web"
        
        Request.httpBody = postString.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
    }
    
    //POST Method
    func RequestForLogin(URLString : String, username : String, password : String)
    {
        print("\n")
        print("Request(POST) " + URLString);
        
        var Request = URLRequest(url: URL(string: URLString)!)
        
        Request.httpMethod = "POST"
        let postString = "grant_type=password&username=" + username + "&password=" + password + "&platform=ios"
        
        print("\n " + postString);
        
        Request.httpBody = postString.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
    }
    
    //PUT Method
    func RequestPUT(Parameters : NSDictionary, URLString : String)
    {
        print("\n")
        print("Request(PUT) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "PUT"
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters)!
            
            print("with Body:\n"+postString!)
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    func RequestPUTWithAutorization(Parameters : NSDictionary, URLString : String)
    {
        print("\n")
        print("Request(PUT) With autorization" + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "PUT"
        let token : String? = UserDefaults.standard.object(forKey: "token") as? String
        if token == nil
        {
            return
        }
        
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters)!
            
            print("with Body:\n"+postString!)
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    
    //POST Method with Token
    func RequestDELETEWithAutorization(Parameters : NSDictionary, URLString : String)
    {
        print("\n")
        print("Request(POST) " + URLString);
        var Request = URLRequest(url: URL(string: URLString)!)
        Request.httpMethod = "DELETE"
        
        let token : String? = UserDefaults.standard.object(forKey: "token") as? String
        print("AuthToken:  " + token!)
        
        Request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        var postString : String? = "";
        
        if Parameters.count != 0
        {
            postString! = try! DictionaryToJSONData(jsonObject: Parameters)!
            
            print("with Body:\n"+postString!)
            
        }
        
        Request.httpBody = postString?.data(using: .utf8)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    func uploadFile(urlString : String, file : Data, fileName : String, type : String) {
        
        var Request  = URLRequest(url: URL(string: urlString)!)
        Request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        Request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        Request.httpBody = createBodyFile(parameters: ["test":"test"],
                                          boundary: boundary,
                                          data: file,
                                          mimeType: type,
                                          filename: fileName)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    func uploadFileWithToken(urlString : String, file : Data, fileName : String, type : String) {
        
        let token : String? = UserDefaults.standard.object(forKey: "token") as? String
        if token == nil
        {
            return
        }
        
        var Request  = URLRequest(url: URL(string: urlString)!)
        Request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        Request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        Request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        Request.httpBody = createBodyFile(parameters: ["test":"test"],
                                          boundary: boundary,
                                          data: file,
                                          mimeType: type,
                                          filename: fileName)
        
        if Tools.hasInternet()
        {
            requestTimer()
            ExecuteTask(Request: Request)
        }
        else {
            notInternetAlert()
        }
        
    }
    
    func createBodyFile(parameters: [String: String],
                        boundary: String,
                        data: Data,
                        mimeType: String,
                        filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    func notInternetAlert()
    {
        print("No connection available") //ZEP
        self.delegate?.onError(error:"conexion", name : self.currentService!)
        Tools.showNotConnectionAvailable(inView: self.controller!)
        //Tools.showSlowConnectionView(inView: self.controller!)
    }
    
    func requestTimer()
    {
        requestDone = false
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0), target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    @objc func countDown()
    {
        if timer == nil
        {
            return
        }
        
        if seconds == nil
        {
            seconds = -1
        }
        
        seconds = seconds! + 1
        print("Conection time: " + String(describing: seconds))
        
        if self.currentService != ServiceName.uploadFile {
            
            if seconds == ServiceRequest.SECONDS_TO_SHOW_SLOW_CONNECTION && requestDone == false
            {
                if (self.controller != nil)
                {
                    Tools.showSlowConnectionView(inView: self.controller!)
                }
            }
        } else {
            
            if seconds == 30 && requestDone == false {
                if (self.controller != nil)
                {
                    Tools.showSlowConnectionView(inView: self.controller!)
                }
            }
        }
        
        if requestDone == true
        {
            timer?.invalidate()
            timer = nil
            seconds = nil
        }
        
    }
    
    func ExecuteTask(Request : URLRequest){
        let task = URLSession.shared.dataTask(with: Request) { data, response, error in
            
            guard let data = data, error == nil else
            {
                self.requestDone = true
                print("Error (😔😢😭)")
                print("FATAL ERROR:\n\(String(describing: error!))")
                self.delegate?.onError(error: "FATAL", name : self.currentService!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse
            {
                print("HTTP STATUS: " + httpStatus.statusCode.description + "\n\n")
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 404
            {
                
                //OnSuccess with error
                self.requestDone = true
                print("OK (😯😄😃)")
                let responseString = String(data: data, encoding: .utf8)
                print("Result:\n \(String(describing: responseString!))")
                
                var dataResult : NSDictionary?
                
                if Tools.JSONDataToDiccionary(text: responseString!) != nil {
                    dataResult = Tools.JSONDataToDiccionary(text: responseString!)! as NSDictionary
                }
                

                if dataResult != nil {
                    let content : NSDictionary? = dataResult
                    var message : String?
                    if content == nil {
                        message = Strings.serverError
                    }
                    message = content?.object(forKey: "error_message") as? String
                    if message == nil {
                        message = Strings.serverError
                    }
                    self.delegate?.onError(error: message!, name : self.currentService!)
                    return
                } else {
                    
                    print("Error (😔😢😭)")
                    print("FATAL ERROR:\n")
                    self.delegate?.onError(error: "FATAL", name : self.currentService!)
                    return
                }
                
                
                
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 400
            {
                //OnSuccess with error
                self.requestDone = true
                print("OK (😯😄😃)")
                let responseString = String(data: data, encoding: .utf8)
                print("Result:\n \(String(describing: responseString!))")
                
                /*let dataResult : NSDictionary = Tools.JSONDataToDiccionary(text: responseString!)! as NSDictionary
                 
                 let error_description : String? = dataResult.object(forKey: "error_description") as? String
                 if error_description != nil
                 {
                 let errorString = NSLocalizedString("The user name or password is incorrect.", comment: "The user name or password is let.")
                 self.delegate?.onError(error: errorString, name: self.currentService!)
                 return
                 }
                 
                 let content : NSDictionary? = dataResult.object(forKey: "content") as? NSDictionary
                 
                 var errorString = ""
                 
                 if errorString == ""
                 {
                 var ValidationErrorMessage : String? = content?.object(forKey: "ValidationErrorMessage") as? String
                 
                 if ValidationErrorMessage == nil
                 {
                 ValidationErrorMessage = Strings.serverError
                 }
                 
                 errorString = ValidationErrorMessage!
                 }*/
                
                self.delegate?.onError(error: String(describing: responseString!), name: self.currentService!)
                return
            }
            
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 202
//            {
//                //OnSuccess with error
//                self.requestDone = true
//                print("OK (😯😄😃)")
//                let responseString = String(data: data, encoding: .utf8)
//                print("Result:\n \(String(describing: responseString!))")
//
//                let dataResult : NSDictionary = Tools.JSONDataToDiccionary(text: responseString!)! as NSDictionary
//
//                let error_description : String? = dataResult.object(forKey: "error") as? String
//                if error_description != nil
//                {
//                    self.delegate?.onError(error: error_description!, name: self.currentService!)
//                }
//                else
//                {
//                    self.delegate?.onError(error: Strings.serverError, name: self.currentService!)
//                }
//
//                return
//            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 || httpStatus.statusCode == 201 || httpStatus.statusCode == 202
            {
                
                //OnSuccess
                self.requestDone = true
                print("OK (😯😄😃)")
                let responseString = String(data: data, encoding: .utf8)
                
                let result : ResultModel = ResultModel();
                result.env = ""
                result.success = false
                result.content = ""
                result.generated = ""
                result.api_version = ""
                result.code = httpStatus.statusCode
                
                if Tools.JSONDataToDiccionary(text: responseString!) != nil
                {
                    print("\nBACKEND JSON RESULT:\n\n" + responseString!)
                    
                    let dataResult : NSDictionary = Tools.JSONDataToDiccionary(text: responseString!)! as NSDictionary
                    
                    result.env = dataResult.object(forKey: "env") as? String
                    result.success = true
                    //let content : NSDictionary? =  dataResult.object(forKey: "content") as? NSDictionary
                    result.content = dataResult
                    result.generated = dataResult.object(forKey: "generated") as? String
                    result.api_version = dataResult.object(forKey: "api_version") as? String
                }
                else
                {
                    
                    result.success = true
                    if responseString != ""
                    {
                        let responseString2 = "{\"data\": " + responseString! + "}"
                        print("\nBACKEND JSONARRAY RESULT:\n\n" + responseString2)
                        
                        
                        if responseString  != "\"\""
                        {
                            if responseString!.contains("doctypehtml") {
                                self.requestDone = true
                                print("Error (😣😖😵)")
                                //print("Status Code: \(httpStatus.statusCode)")
                                //print("\nDescription error:\(String(describing: error!))")
                                print("response = \(String(describing: response!))")
                                self.notInternetAlert()
                                self.delegate?.onError(error: Strings.serverError, name : self.currentService!)
                                return
                                
                            }else{
                                let dataResult : NSDictionary = Tools.JSONDataToDiccionary(text: responseString2)! as NSDictionary
                                let array : [NSDictionary] = dataResult.object(forKey: "data") as! [NSDictionary]
                                result.content = array
                            }
                        } else {
                            result.content = "Ok"
                        }
                        
                    }
                    
                }
                
                
 
                if result.success == true{
                    self.delegate?.onSucces(result: result, name : self.currentService!)
                }
                else{
                    let errorString : String = result.content as! String
                    self.delegate?.onError(error: errorString, name: self.currentService!)
                }
                
                
            }
            else{
                //OnError
                self.requestDone = true
                print("Error (😣😖😵)")
                //print("Status Code: \(httpStatus.statusCode)")
                //print("\nDescription error:\(String(describing: error!))")
                print("response = \(String(describing: response!))")
                self.delegate?.onError(error: Strings.serverError, name : self.currentService!)
            }
            
        }
        
        task.resume()
    }
    
    func DictionaryToJSONData(jsonObject: AnyObject) throws -> String?
    {
        let data: NSData? = try? JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
        
        var jsonStr: String?
        if data != nil {
            jsonStr = String(data: data! as Data, encoding: String.Encoding.utf8)
        }
        
        return jsonStr
    }
    
    func JSONDataToDiccionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

