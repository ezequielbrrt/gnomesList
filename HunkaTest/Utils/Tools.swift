//
//  Tools.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Kingfisher


class Tools: NSObject{
    
    static let screenHeight = Int(UIScreen.main.bounds.size.height);
    
    class func RGB(r : Int, g : Int, b : Int) -> UIColor
    {
        return UIColor.init(red: RGBNumber(number: r),
                            green: RGBNumber(number: g),
                            blue: RGBNumber(number: b),
                            alpha: 1.0)
    }
    
    class func RGBNumber(number : Int) -> CGFloat
    {
        return CGFloat.init(Double(number) / 255.0)
    }
    
    class func setRoundedView(view:UIView, radious: Float32){
        view.layer.cornerRadius = CGFloat(radious)
    }
    
    class func iPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class func setFont(UIComponent : NSObject, isBold: Bool = false, isLight: Bool = false)
    {
        if UIComponent is UIButton {
            if isLight{
                (UIComponent as! UIButton).titleLabel?.font = UIFont.init(name: AppConfigurator.fontBold, size: ((UIComponent as! UIButton).titleLabel?.font.pointSize)!)
                
            }else{
                (UIComponent as! UIButton).titleLabel?.font = UIFont.init(name: AppConfigurator.fontBold, size: 18)
                
            }
            
        }
        
        if UIComponent is UILabel {
            
            if isBold{
                (UIComponent as! UILabel).font = Tools.fontAppBold(withSize: (UIComponent as! UILabel).font.pointSize)
            }else if isLight{
                (UIComponent as! UILabel).font = Tools.fontAppLight(withSize: (UIComponent as! UILabel).font.pointSize)
            }else{
                (UIComponent as! UILabel).font = Tools.fontAppRegular(withSize: (UIComponent as! UILabel).font.pointSize)
            }
        }
        
        if UIComponent is UITextField {
            //(UIComponent as! UITextField).font = Tools.fontAppBold(withSize: (UIComponent as! UITextField).font!.pointSize)
            (UIComponent as! UITextField).font = Tools.fontAppRegular(withSize: (UIComponent as! UITextField).font!.pointSize)
        }
        
        if UIComponent is UITextView {
            (UIComponent as! UITextView).font = Tools.fontAppRegular(withSize: (UIComponent as! UITextView).font!.pointSize)
            (UIComponent as! UITextView).tintColor = AppConfigurator.mainColor
        }
    }
    
    //Font App
    class func fontAppRegular(withSize : CGFloat) -> UIFont {
        let font = UIFont(name: AppConfigurator.fontRegular, size: withSize)!
        return font
    }
    
    class func fontAppBold(withSize : CGFloat) -> UIFont {
        return UIFont(name: AppConfigurator.fontBold, size: withSize)!
    }
    
    class func fontAppLight(withSize: CGFloat) -> UIFont{
        return UIFont(name: AppConfigurator.fontLight, size: withSize)!
    }
    
    
    
    class func attributeRegular() -> [NSAttributedString.Key : Any] {
        let attrsRegular = [
            NSAttributedString.Key.font: UIFont(name: AppConfigurator.fontRegular, size: 13.0)!,
            NSAttributedString.Key.foregroundColor : AppConfigurator.mainColor,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        return attrsRegular;
    }
    
    class func feedback()
    {
        let generator = UIImpactFeedbackGenerator(style:.light)
        generator.impactOccurred()
    }
    
    
    class func feedbackError()
    {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    class func attributeLight() -> [NSAttributedString.Key : Any] {
        let attrsLight = [
            NSAttributedString.Key.font: UIFont(name: AppConfigurator.fontLight, size: 13.0)!,
            NSAttributedString.Key.foregroundColor : AppConfigurator.mainColor,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        return attrsLight;
    }
    
    class func upView(View : UIView, Points : CGFloat) {
        var NewFrame : CGRect = View.frame
        NewFrame.origin.y = View.frame.origin.y - Points
        View.frame = NewFrame
    }
    
    class func downView(View : UIView, Points : CGFloat) {
        var NewFrame : CGRect = View.frame
        NewFrame.origin.y = View.frame.origin.y + Points
        View.frame = NewFrame
    }
    
    class func pushViewCenter(View : UIView, Points : CGFloat) {
        var NewFrame : CGPoint = View.center
        NewFrame.x = View.center.x + Points;
        View.center = NewFrame
    }
    
    class func pullViewCenter(View : UIView, Points : CGFloat) {
        var NewFrame : CGPoint = View.center
        NewFrame.x = View.center.x - Points;
        View.center = NewFrame
    }
    
    
    //Convert String (response) to Nsdictionary
    class func JSONDataToDiccionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
    
    class func notification(inView : UIViewController, withText : String, data: NSDictionary? = nil, openNotification: Bool = true)
        {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
            let storyboard = UIStoryboard.init(name: "Tools", bundle: nil)
            let doneView : doneView = storyboard.instantiateViewController(withIdentifier: "lastSessionView") as! doneView
            doneView.openNotification = openNotification
            
            var screenWidth = UIScreen.main.bounds.size.width
            var screenX = CGFloat(0)
            if iPad() { screenWidth = (UIScreen.main.bounds.size.width / 2)
                screenX = UIScreen.main.bounds.size.width / 4
            }
            let screenFrame : CGRect = CGRect(x: screenX,
                                              y: 0,
                                              width: screenWidth,
                                              height: 100)
            
            doneView.view.frame = screenFrame
            doneView.data = data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
    //        if appDelegate.mainControllerApp != nil {
    //            appDelegate.mainControllerApp?.view.addSubview(doneView.view)
    //            appDelegate.mainControllerApp?.view.bringSubviewToFront(doneView.view)
    //        }
    //        else {
    //            inView.view.addSubview(doneView.view);
    //            inView.view.bringSubviewToFront(doneView.view)
    //        }
            
            inView.view.addSubview(doneView.view);
            inView.view.bringSubviewToFront(doneView.view)
            doneView.textDisplay?.text = withText
            doneView.show()
            
            let dispatchTime = (DispatchTime.now() + 3.0)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime)
            {
                doneView.hidden()
            }
        }
    
    
    class func showSlowConnectionView (inView : UIViewController){
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        let storyboard = UIStoryboard.init(name: "Tools", bundle: nil)
        let slowConnectionView : slowConnection = storyboard.instantiateViewController(withIdentifier: "slowConnection") as! slowConnection
        
        let screenFrame : CGRect = CGRect(x: 0,
                                          y: -100,
                                          width: UIScreen.main.bounds.size.width,
                                          height: 100)
        
        slowConnectionView.view.frame = screenFrame
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        inView.view.addSubview(slowConnectionView.view);
        inView.view.bringSubviewToFront(slowConnectionView.view)
        
        
        slowConnectionView.show()
        
        let dispatchTime = (DispatchTime.now() + 4.0)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime)
        {
            slowConnectionView.hidden()
        }
    }
    
    class func showNotConnectionAvailable(inView : UIViewController){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if delegate.withoutInternetView != nil{
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        let storyboard = UIStoryboard.init(name: "Tools", bundle: nil)
        let withoutConnectionView : withoutConnection = storyboard.instantiateViewController(withIdentifier: "withoutConnection") as! withoutConnection
        
        let screenFrame : CGRect = CGRect(x: 0,
                                          y: -100,
                                          width: UIScreen.main.bounds.size.width,
                                          height: 100)
        
        withoutConnectionView.view.frame = screenFrame
        
        
      
        inView.view.addSubview(withoutConnectionView.view);
        inView.view.bringSubviewToFront(withoutConnectionView.view)
        
        
        withoutConnectionView.show()
        
        delegate.withoutInternetView = withoutConnectionView
        
        
        let dispatchTime = (DispatchTime.now() + 4.0)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime){
            withoutConnectionView.hidden()
        }
    }
    
    class func setHeightButton(button: UIButton){
        button.heightAnchor.constraint(equalToConstant: CGFloat(UIUitls.buttonHeight.rawValue)).isActive = true
        
    }
    
    class func setHeightUIText(uiText: UITextField){
        uiText.heightAnchor.constraint(equalToConstant: CGFloat(UIUitls.ediTextHeight.rawValue)).isActive = true
    }
    
    class func setRoundedButton(button: UIButton, color: UIColor? = nil){
        button.layer.cornerRadius = CGFloat(UIUitls.radioCorner.rawValue)
        if color != nil{
            button.backgroundColor = color
        }else{
            button.backgroundColor = AppConfigurator.mainColor
        }
        
        
    }
    
    // MARK: Third library
    // Aquí utilice la única librería en toda la apliación que se utlizó para obtener las imágenes
    // y guardarlas en cache para usarlas posteriormente sin tener que descargarlas
    // la librearía se llama Kingfisher la cúal considero una librería bastante completas para
    // trabajar con imagenes en la web y su uso en memoria cache, además de otro tipo de utilidades
    
    class func setImageToCache(image: UIImageView, identifier: String, url: String){
        let cache = ImageCache.default
        let cached = cache.isCached(forKey: identifier)
        
        if cached{
            cache.retrieveImage(forKey: identifier) { result in
                switch result {
                case .success(let value):
                    // If the `cacheType is `.none`, `image` will be `nil`.
                    if value.cacheType != .none{
                        print("obteniendo imagen de cache")
                        DispatchQueue.main.async {
                            image.image = value.image
                        }
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            print("obteniendo imagen")
            let resource = ImageResource(downloadURL: URL(string:url)!, cacheKey: identifier)
            let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))

            image.kf.setImage(with: resource,options: [.processor(processor)])
        }
    }
    
    class func hasInternet() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}


extension UICollectionView{
    func showLoader(){
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.color = AppConfigurator.mainColor
        activityView.startAnimating()
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(activityView)
        
        activityView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        activityView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant:  20).isActive = true
        
        self.backgroundView = emptyView
        
    }
    
    func setEmptyHorizontalView(title: String, messageImage: UIImage? = nil){
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        Tools.setFont(UIComponent: titleLabel, isBold: true)
        emptyView.addSubview(titleLabel)
        
        if messageImage != nil {
            let messageImageView = UIImageView()
            messageImageView.translatesAutoresizingMaskIntoConstraints = false
            
            emptyView.addSubview(messageImageView)
            
            messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            messageImageView.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 10).isActive = true
            messageImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            messageImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            messageImageView.image = messageImage
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { messageImageView.shake()
            }
            
        }else{
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        }
        
        titleLabel.text = title
        self.backgroundView = emptyView
    }
    
    func setEmptyView(title: String, message: String,
                      messageImage: UIImage, select: Selector? = nil,
                      delegate: UIViewController? = nil) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        let messageImageView = UIImageView()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleLabel.textColor = UIColor.black
        
        messageLabel.textColor = UIColor.lightGray
        
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(messageImageView)
        
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -105).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -25).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 25).isActive = true
        
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { messageImageView.shake()
        }
        //Tools.shakeAnimation(viewAnimation: messageImageView, moveScale: 2, minimumAlpha: 8, duration: 2)
        Tools.setFont(UIComponent: titleLabel, isBold: true)
        Tools.setFont(UIComponent: messageLabel, isLight: true)
        
        
        if delegate != nil{
            
            let button = UIButton()
            button.setTitle(Strings.retry, for: .normal)
            button.isEnabled = true
            button.translatesAutoresizingMaskIntoConstraints = false
            emptyView.addSubview(button)
            
            button.addTarget(delegate, action: select!, for: .touchUpInside)
            button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
            button.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
            
            button.setTitleColor(.white, for: .normal)
            button.widthAnchor.constraint(equalToConstant: 120).isActive = true
            button.backgroundColor = AppConfigurator.mainColor
            Tools.setRoundedButton(button: button)
            Tools.setHeightButton(button: button)
            Tools.setFont(UIComponent: button)
        }
        
        
        self.backgroundView = emptyView
    }
    
    
    func restore() {
        self.backgroundView = nil
    }
}

extension UIView {
    func shake() {
        self.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundedNum(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
