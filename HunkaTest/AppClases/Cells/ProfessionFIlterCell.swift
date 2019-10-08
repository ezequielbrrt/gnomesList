//
//  ProfessionFIlterCell.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/4/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class ProfessionFIlterCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Tools.setFont(UIComponent: nameLabel)
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = 5
    }
}
