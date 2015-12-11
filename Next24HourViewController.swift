//
//  Next24HourViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 11/15/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

//, UITableViewDelegate, UITableViewDataSource 
class Next24HourViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var json:NSDictionary!
    var hourInfo:NSArray!
    var timeZone:String!
    var degreeVal:String!
    var expand:Bool!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var TempSymbolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let hourly = json["hourly"] as? NSDictionary{
            if let hours = hourly["data"] as? NSArray{
                let range:NSRange = NSMakeRange(0, 24)
                hourInfo = hours.subarrayWithRange(range)
            }
        }
        
        timeZone = json["timezone"] as? String
        
        if degreeVal == "si"{
            TempSymbolLabel.text = "Temp(\u{00B0}C)"
        }else{
            TempSymbolLabel.text = "Temp(\u{00B0}F)"
        }
        
        expand = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showMoreInfo(sender: AnyObject) {
        expand = true
        if let hourly = json["hourly"] as? NSDictionary{
            if let hours = hourly["data"] as? NSArray{
                hourInfo = hours
            }
        }
        // reload table view
        self.myTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!expand){
            return 25
        }else{
            return hourInfo.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:Next24HourTableViewCell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath) as! Next24HourTableViewCell
        let row = indexPath.row
        if (row == 24 && expand == false){
            cell.hourLabel.text = ""
            cell.temperatureLabel.text = ""
            cell.iconImage.hidden = true
            cell.moreButton.hidden = false
            cell.moreButton.enabled = true
            cell.moreButton.setImage(UIImage(named: "low_priority-50"), forState: .Normal)
        }else{
            if let hourlyInfo = hourInfo[row] as? NSDictionary{
                if let hourlyTime = hourlyInfo["time"] as? Double{
                    let date = NSDate(timeIntervalSince1970:hourlyTime)
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "H:mm a"
                    formatter.timeZone = NSTimeZone(name: timeZone)
                    let sunriseTime = formatter.stringFromDate(date)
                    cell.hourLabel.text = sunriseTime
                }
                if let hourlySummary = hourlyInfo["icon"] as? String{
                    cell.iconImage.image = UIImage(named: hourlySummary)
                }
                
                if let temperature = hourlyInfo["temperature"] as? Double{
                    cell.temperatureLabel.text = String(Int(round(temperature)))
                }
                cell.moreButton.hidden = true
                cell.moreButton.enabled = false
                cell.iconImage.hidden = false
            }
        }
        if row % 2 == 1{
            cell.backgroundColor = UIColor.grayColor()
        }
        if row % 2 == 0{
            cell.backgroundColor = UIColor.whiteColor()
        }
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
