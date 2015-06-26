//
//  SettingsTableViewController.swift
//  Hidden Charm
//
//  Created by Fhict on 28/05/15.
//  Copyright (c) 2015 Merint van Senus. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var settingTypesArray = ["Nickname","Language","Delay"]
    var delayArray = ["1 month","1 week", "1 day", "12 hours", "6 hours", "3 hours", "1 hour"]
    
    let screenSize: CGSize = UIScreen.mainScreen().applicationFrame.size
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var mypicker :UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userDefaults.setValue("R2D2", forKey: "Nickname")
        //userDefaults.setValue("1 day", forKey: "Delay")
        //userDefaults.setValue("English", forKey: "Language")
        
        if(userDefaults.valueForKey("Nickname")==nil){
        userDefaults.setValue("R2D2", forKey: "Nickname")
        userDefaults.setValue("1 day", forKey: "Delay")
        userDefaults.setValue("English", forKey: "Language")
        userDefaults.setObject(NSDate(), forKey: "receiveDate")
        }
        
        var pickerFrame = CGRectMake((screenSize.width/6) , screenSize.height/6 - 40, screenSize.width/2, screenSize.height/3)
        
        mypicker = UIPickerView(frame: pickerFrame)
        mypicker!.dataSource = self
        mypicker!.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
    }
    
    func loadList(notification: NSNotification){
        //load data here
        println("viewWillReload")
        self.tableView.reloadData()
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

        cell.textLabel?.text = settingTypesArray[indexPath.row]
        
        let swiftColor = UIColor(red: 0.95, green: 0.99, blue: 0.99, alpha: 1)
        let swiftColor2 = UIColor(red: 0.95, green: 0.99, blue: 0.97, alpha: 1)
        // Configure the cell...
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = swiftColor2
        }
        else
        {
            cell.backgroundColor = swiftColor
        }
        
        if(indexPath.row == 0)
        {
            cell.detailTextLabel!.text = userDefaults.valueForKey("Nickname") as! String
        }
        else if(indexPath.row == 1)
        {
            cell.detailTextLabel!.text = userDefaults.valueForKey("Language") as! String
        }
        else if(indexPath.row == 2)
        {
            cell.detailTextLabel!.text = userDefaults.valueForKey("Delay") as! String
        }

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
                self.userDefaults.setValue(txtboxNickName.text, forKey: "Nickname")
                self.userDefaults.synchronize()
                self.tableView.reloadData()
            }))
            
            
            nameAlert.addTextFieldWithConfigurationHandler{ (textfield) in
                textfield.text = self.userDefaults.valueForKey("Nickname") as! String
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
        else if(row == 2)
        {
            var nameAlert = UIAlertController(title: "Delay", message: "\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.Alert)
            nameAlert.modalInPopover = true
            
            nameAlert.view.addSubview(mypicker!)

            
            nameAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                //nothing happens when it is cancelled
                
            }))
            
            nameAlert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action: UIAlertAction!) in
                self.userDefaults.setValue(self.delayArray[self.mypicker!.selectedRowInComponent(0)], forKey: "Delay")
                self.userDefaults.synchronize()
                self.tableView.reloadData()
            }))

            self.presentViewController(nameAlert, animated: true) {
                
            }
            return false
            
        }
        else
        {
            return false
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return delayArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return delayArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //todo
        let index = row.description.toInt()
        //todo: shit moet veranderen na selecteren
        
        
        
    }
    

}
