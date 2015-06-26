//
//  MainTableViewController.swift
//  
//
//  Created by Fhict on 28/05/15.
//
//

import UIKit

class MainTableViewController: UITableViewController {

    @IBOutlet weak var SettingsButton: UIButton!
    
    var nameArray = ["Max","Eric","Michael", "John", "Meny", "Luc", "Merint", "Gerda", "Jan"]
    
    @IBAction func AddContact(sender: UIButton)
    {
        var nameAlert = UIAlertController(title: "Start new chat?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        nameAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        nameAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            let randomNumber = Int(arc4random_uniform(UInt32(9)))
            self.testArray.append(self.nameArray[randomNumber])
            self.tableView.reloadData()
        }))
        
        
        self.presentViewController(nameAlert, animated: true)
        {
            
        }

    }
    var testArray = ["Nientje","Janneke","Lisa","Linda"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return testArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let swiftColor = UIColor(red: 0.95, green: 0.99, blue: 0.99, alpha: 1)
        let swiftColor2 = UIColor(red: 0.98, green: 0.99, blue: 0.99, alpha: 1)
        // Configure the cell...
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = swiftColor2
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        cell.textLabel?.text = testArray[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "messageSegue") {
            var selectedRow = self.tableView.indexPathForSelectedRow()
            var controller = segue.destinationViewController as! ViewController
            controller.partnerName = testArray[selectedRow!.row]
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") {
            action, index in
            self.testArray.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
        delete.backgroundColor = UIColor.redColor()
        
        let fav = UITableViewRowAction(style: .Normal, title: "Favorite") {
            action, index in
            var nameAlert = UIAlertController(title: "Favorite", message: "Add to favorites", preferredStyle: UIAlertControllerStyle.Alert)
            nameAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            
            nameAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            self.presentViewController(nameAlert, animated: true){}
            
            
        }
        fav.backgroundColor = UIColor.yellowColor()
        
        return [delete, fav]
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            println("deleted")
        } else if editingStyle == UITableViewCellEditingStyle.Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}