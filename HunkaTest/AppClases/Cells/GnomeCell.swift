//
//  GnoneCell.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/3/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit
import Kingfisher

class GnomeCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var widthTitleLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTitleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Tools.setRoundedView(view: containerView, radious: 15)
        colorView.layer.cornerRadius = 16
        colorView.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        Tools.setFont(UIComponent: nameLabel)
        Tools.setFont(UIComponent: widthLabel)
        Tools.setFont(UIComponent: widthTitleLabel)
        Tools.setFont(UIComponent: heightLabel)
        Tools.setFont(UIComponent: heightTitleLabel)
        containerView.layer.shadowColor =  UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 12.0
        containerView.layer.shadowOpacity = 0.4
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = AppConfigurator.mainColor.cgColor
        profileImageView.kf.indicatorType = .activity
        profileImageView.setRounded()
        
    }
}
