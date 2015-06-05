//
//  SettingsTableViewController.swift
//  Hidden Charm
//
//  Created by Fhict on 28/05/15.
//  Copyright (c) 2015 Merint van Senus. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var testArray = ["Nickname","Language","Delay"]
    var testArray2 = ["R2D2","3 languages enabled","6 hours"]
    
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
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = testArray[indexPath.row]
        cell.detailTextLabel?.text = testArray2[indexPath.row]

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        var selectedRow = self.tableView.indexPathForSelectedRow()!.row
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        var row = self.tableView.indexPathForSelectedRow()?.row
        if(row == 0)
        {
            var nameAlert = UIAlertController(title: "Rename", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
            nameAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                //nothing happens when it is cancelled
                
            }))
            
            nameAlert.addAction(UIAlertAction(title: "Rename", style: .Default, handler: { (action: UIAlertAction!) in
                //something happens
                var txtboxNickName = nameAlert.textFields?[0] as! UITextField
                self.testArray2[0] = txtboxNickName.text
                self.tableView.reloadData()
            }))
            
            
            nameAlert.addTextFieldWithConfigurationHandler{ (textfield) in
                textfield.text = self.testArray2[0]
            }
            
            self.presentViewController(nameAlert, animated: true) {
                var textfield = nameAlert.textFields?[0] as! UITextField
                textfield.selectAll(nil)
            }

            
            return false
        }
        else if(row == 1)
        {
            return true
        }
        else
        {
            return false
        }
    }
    

}
