//
//  doneView.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class doneView: UIViewController {
    
    @IBOutlet weak var viewConnection : UIView?
    @IBOutlet weak var textDisplay : UILabel?
    @IBOutlet weak var appIcon : UIImageView?
    
    var data: NSDictionary?
    var openNotification: Bool = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var panGesture = UIPanGestureRecognizer()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        viewConnection?.isUserInteractionEnabled = true
        viewConnection?.addGestureRecognizer(panGesture)
        
        //        appIcon?.image = AppConfigurator.appIcon
        //        appIcon?.layer.cornerRadius = 10
        appIcon?.clipsToBounds = true
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(viewConnection!)
        let translation = sender.translation(in: self.view)
        
        if translation.y <= 0.0 {
            viewConnection?.center = CGPoint(x: (viewConnection?.center.x)!, y: (viewConnection?.center.y)! + translation.y * 3.0)
        }
        sender.setTranslation(CGPoint.zero, in: viewConnection)
        if (viewConnection?.center.y)! < CGFloat(-1) {
            hidden()
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if viewConnection != nil
        {
            viewConnection?.alpha = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //textDisplay?.adjustsFontSizeToFitWidth = true
        Tools.upView(View: self.viewConnection!, Points: 60)
    }
    
    func show()
    {
        viewConnection?.alpha = 1
        
        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations:
            {
                self.view.alpha = 1
                
                if Tools.screenHeight > 800{
                    Tools.downView(View: self.viewConnection!, Points: 100)
                }else{
                    Tools.downView(View: self.viewConnection!, Points: 80)
                }
                
                
        }, completion:
            { _ in
        })
    }
    
    func show(withAlpha : CGFloat)
    {
        viewConnection?.alpha = withAlpha;
        
        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations:
            {
                self.view.alpha = 1
                
                Tools.downView(View: self.viewConnection!, Points: 80)
                
        }, completion:
            { _ in
        })
    }
    
    
    func hidden()
    {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations:
            {
                self.view.alpha = 0
                Tools.upView(View: self.viewConnection!, Points: 80)
                
        }, completion:
            { _ in
                
                self.view.removeFromSuperview()
                self.removeFromParent()
                
        })
    }
    
    @IBAction func hiddenAction()
    {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations:
            {
                self.view.alpha = 0
                self.view.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
                
        }, completion:
            { _ in
                
                self.view.removeFromSuperview()
                self.removeFromParent()
                
        })
    }
    
    @IBAction func opentClickView(_ sender: UIButton) {
        
        if openNotification{
            print("")
        }
        
    }
    

    
    
}
