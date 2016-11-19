//
//  DoneViewController.swift
//  blackbelt
//
//  Created by Jennifer Zeller on 9/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

class DoneViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as! MyCell
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.taskLabel.text = completes[indexPath.row].name
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM dd"
        
        let dateString = dateFormatter.stringFromDate(completes[indexPath.row].date!)
        
        cell.dateLabel.text = dateString
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(completes[indexPath.row])
        saveChanges()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })    }
    
    func saveChanges() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
    }
    
    func fetchAllCompletes() {
        
        // collect entities with the name Mission
        let userRequest = NSFetchRequest(entityName: "Complete")
        do {
            // try to fetch the requested entities as an array of objects
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            completes = results as! [Complete]
        } catch {
            // error catch
            print("\(error)")
        }
    }
    
}
