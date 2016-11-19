//
//  ViewController.swift
//  blackbelt
//
//  Created by Jennifer Zeller on 9/26/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import CoreData

// var tasks = ["one","two","three"]
var tasks = [Task]()
var completes = [Complete]()
var indexStored = 0


class MainViewController: UITableViewController, CustomCellDelegate, CancelButtonDelegate, EditViewControllerDelegate {
    
    var taskToEdit:Task?
    var nameOfTask:String?
    

    // create scratchpad
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTasks()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! EditViewController
        controller.cancelButtonDelegate = self
        controller.delegate = self
        if segue.identifier == "addItem"{
        }
        if segue.identifier == "editItem"{
            print("we are editing")
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                print(sender)
                controller.taskToEdit = tasks[indexPath.row]
                controller.taskToEditIndexPath = indexPath.row
            }
            // does this need to be a Task instead of the name string?
            controller.editTask = tasks[indexStored].name
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        // let correctString = memories[indexPath.row].fileName!


        // assign name to text label
        cell.taskLabel?.text = tasks[indexPath.row].name
        
        // set delegate for cell
        cell.buttonDelegate = self
        
        // send index to cell
        cell.index = indexPath.row
        print(cell.index)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("editItem", sender: tableView.cellForRowAtIndexPath(indexPath))
        indexStored = indexPath.row

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func cancelButtonPressedFrom(controller: UIViewController){
        dismissViewControllerAnimated(true, completion: nil)
        fetchAllTasks()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(tasks[indexPath.row])
        saveChanges()
        fetchAllTasks()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })    }

    
    ////////// Delegate Stuff //////////
    
    func beastButtonPressedFrom(cell: CustomCell) {
        taskToEdit = tasks[cell.index]
        nameOfTask = taskToEdit?.name
        // add item to complete using task item
        let completeTask = NSEntityDescription.insertNewObjectForEntityForName("Complete", inManagedObjectContext: managedObjectContext) as! Complete
        completeTask.setValue(nameOfTask, forKey: "name")
        completeTask.setValue(NSDate(), forKey: "date")

        // remove task item
        managedObjectContext.deleteObject(tasks[cell.index])
        
        // reload table data
        saveChanges()
        fetchAllTasks()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        
    }
    
    func editViewController(controller: EditViewController, didFinishAddingTask task: String){
        print("dismiss view")
        dismissViewControllerAnimated(true, completion: nil)
        let newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: managedObjectContext) as! Task
        newTask.setValue(task, forKey: "name")
        print("this is the new task:",newTask)
        tasks.append(newTask)
        saveChanges()
        fetchAllTasks()
        fetchAllCompletes()
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    func editViewControllerEdit(controller: EditViewController,  didFinishEditingTask task: Task){
        dismissViewControllerAnimated(true, completion: nil)
        fetchAllTasks()
        fetchAllCompletes()

        //setValue(mission, forKey: "details")
        //missions = missions.filter
        //missions.insert(mission, atIndex: indexPath)
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }


    /////// FETCH AND SAVE //////
    
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
    
    
    func fetchAllTasks() {
        
        // collect entities with the name Mission
        let userRequest = NSFetchRequest(entityName: "Task")
        do {
            // try to fetch the requested entities as an array of objects
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            tasks = results as! [Task]
        } catch {
            // error catch
            print("\(error)")
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

