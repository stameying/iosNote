//
//  Next7DayTableViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 11/16/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

class Next7DayTableViewController: UITableViewController {
    
    var json:NSDictionary!
    var degreeVal:String!
    var dailyInfo:NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let daily = json["daily"] as? NSDictionary{
            if let dailyData = daily["data"] as? NSArray{
                dailyInfo = dailyData
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dailyInfo.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:Next7DayTableViewCell = tableView.dequeueReusableCellWithIdentifier("next7dayCell", forIndexPath: indexPath) as! Next7DayTableViewCell
        
        // Configure the cell...
        let row = indexPath.row
        
        if let dailyInformation = dailyInfo[row] as? NSDictionary{
            if let dateStamp = dailyInformation["time"] as? Double{
                let date = NSDate(timeIntervalSince1970:dateStamp)
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM dd"
                let dayOfWeekString = dateFormatter.stringFromDate(date)
                cell.dateLabel.text = dayOfWeekString
            }
            
            if let icon = dailyInformation["icon"] as? String{
                cell.iconImage.image = UIImage(named: icon)
            }
            
            var minmaxString = ""
            if let minTemp = dailyInformation["temperatureMin"] as? Double{
                minmaxString += "Min: \(Int(round(minTemp)))"
                if degreeVal == "si"{
                    minmaxString += "\u{00B0}C |"
                }else{
                    minmaxString += "\u{00B0}F |"
                }
            }
            if let maxTemp = dailyInformation["temperatureMax"] as? Double{
                minmaxString += "Max: \(Int(round(maxTemp)))"
                if degreeVal == "si"{
                    minmaxString += "\u{00B0}C"
                }else{
                    minmaxString += "\u{00B0}F"
                }
            }
            cell.lowhighLabel.text = minmaxString
        }
        
        if row % 7 == 0 {
            cell.backgroundColor = UIColor(red: 1.000, green: 0.875, blue: 0.373, alpha: 1.00)
        }else if row % 7 == 1 {
            cell.backgroundColor = UIColor(red: 0.545, green: 0.914, blue: 1.000, alpha: 1.00)
        }else if row % 7 == 2 {
            cell.backgroundColor = UIColor(red: 1.000, green: 0.737, blue: 0.914, alpha: 1.00)
        }else if row % 7 == 3 {
            cell.backgroundColor = UIColor(red: 0.671, green: 1.000, blue: 0.647, alpha: 1.00)
        }else if row % 7 == 4 {
            cell.backgroundColor = UIColor(red: 1.000, green: 0.722, blue: 0.702, alpha: 1.00)
        }else if row % 7 == 5 {
            cell.backgroundColor = UIColor(red: 0.906, green: 1.000, blue: 0.702, alpha: 1.00)
        }else{
            cell.backgroundColor = UIColor(red: 0.753, green: 0.722, blue: 1.000, alpha: 1.00)
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
