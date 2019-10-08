//
//  CustomUI.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class slowConnection: UIViewController {
    
    @IBOutlet weak var viewConnection : UIView?
    @IBOutlet weak var textDisplay : UILabel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        textDisplay?.text = Strings.slowConnection
        
        textDisplay?.adjustsFontSizeToFitWidth = true
        Tools.setFont(UIComponent: textDisplay!)
        
        if viewConnection != nil
        {
            viewConnection?.alpha = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        //Tools.DownView(View: self.viewConnection!, Points: 100)
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
        })
    }
    
}

