//
//  CustomCell.swift
//  blackbelt
//
//  Created by Jennifer Zeller on 9/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    var index = 0
    
    var buttonDelegate: CustomCellDelegate?
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBAction func beastButtonPressed(sender: UIButton) {
        buttonDelegate?.beastButtonPressedFrom(self)
    }
    
}
