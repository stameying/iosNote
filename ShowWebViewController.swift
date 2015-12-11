//
//  ShowWebViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 11/13/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

class ShowWebViewController: UIViewController {
    
    
    @IBOutlet weak var myWebView: UIWebView!
    func displayWeb(){
        let targetAddress = "http://forecast.io"
        let targetURL = NSURL(string: targetAddress)
        let myRequest = NSURLRequest(URL: targetURL!)
        myWebView.loadRequest(myRequest)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeb()
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
