//
//  CustomCellDelegate.swift
//  blackbelt
//
//  Created by Jennifer Zeller on 9/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCellDelegate: class {
    func beastButtonPressedFrom(cell: CustomCell)
}