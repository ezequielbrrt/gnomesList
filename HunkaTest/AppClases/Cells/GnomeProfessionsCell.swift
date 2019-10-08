//
//  GnomeProfessionsCell.swift
//  HunkaTest
//
//  Created by Ezequiel Barreto on 10/4/19.
//  Copyright © 2019 Ezequiel Barreto. All rights reserved.
//

import UIKit

class GnomeProfessionsCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Tools.setFont(UIComponent: nameLabel)
    }
}
