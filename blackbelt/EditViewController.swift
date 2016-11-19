//
//  EditViewController.swift
//  blackbelt
//
//  Created by Jennifer Zeller on 9/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: EditViewControllerDelegate?

    var editTask:String?
    
    var taskToEdit: Task?
    var taskToEditIndexPath: Int?

    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if let task = taskToEdit {
            task.setValue(textField.text!, forKey: "name")
            delegate?.editViewControllerEdit(self, didFinishEditingTask: task)
        } else { // we are adding so run the "didFinishAddingMission" method
            print("we are adding")
            let task = textField.text!
            delegate?.editViewController(self, didFinishAddingTask: task)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = taskToEdit?.name

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
