//
//  EditViewControllerDelegate.swift
//  blackbelt
//
//  Created by Jennifer Zeller on 9/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import Foundation
protocol EditViewControllerDelegate: class {
    func editViewController(controller: EditViewController, didFinishAddingTask task: String)
    func editViewControllerEdit(controller: EditViewController, didFinishEditingTask task: Task)
}