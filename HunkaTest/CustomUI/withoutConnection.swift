//
//  withoutConnection.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class withoutConnection: UIViewController
{
    
    @IBOutlet weak var viewConnection : UIView?
    @IBOutlet weak var textDisplay : UILabel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        textDisplay?.text = Strings.notConnection
        textDisplay?.adjustsFontSizeToFitWidth = true
        
        if viewConnection != nil
        {
            viewConnection?.alpha = 0
        }
        Tools.setFont(UIComponent: textDisplay!)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //Tools.UpView(View: self.viewConnection!, Points: 120)
    }
    
    func show()
    {
        viewConnection?.alpha = 1
        
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations:
            {
                self.view.alpha = 1
                Tools.downView(View: self.viewConnection!, Points: 130)
                
        }, completion:
            { _ in
        })
    }
    
    func hidden()
    {
        UIView.animate(withDuration: 0.30, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations:
            {
                self.view.alpha = 0
                Tools.upView(View: self.viewConnection!, Points: 130)
                
        }, completion:
            { _ in
                
                self.view.removeFromSuperview()
                self.removeFromParent()
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.withoutInternetView = nil
        })
    }
    
}

