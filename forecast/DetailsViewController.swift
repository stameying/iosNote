//
//  DetailsViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 11/15/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

class DetailsViewController: UITabBarController {
    
    var json:NSDictionary!
    var degreeVal:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let childViewControllers = self.viewControllers
        let next24hourVC = childViewControllers![0] as! Next24HourViewController
        next24hourVC.json = json
        next24hourVC.degreeVal = degreeVal
        
        let next7dayVC = childViewControllers![1] as! Next7DayTableViewController
        next7dayVC.json = json
        next7dayVC.degreeVal = degreeVal
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
