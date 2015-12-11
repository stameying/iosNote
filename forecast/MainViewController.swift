//
//  MainViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 11/13/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SelectStateDelegate {

    @IBOutlet weak var streetInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var stateInput: UIButton!
    @IBOutlet weak var degreeInput: UISegmentedControl!
    @IBOutlet weak var validateOutput: UILabel!

    var stateData: [String] = [String]()
    var street:String!
    var city:String!
    var state:String!
    var degreeVal:String!
    var testData:String!
    var json:NSDictionary!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        stateData = ["Alabama","Alaska","Arizona","Arkansas","California"]
        state = ""
        testData = "test"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func textFieldReturn(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    
    @IBAction func submit(sender: AnyObject){
         street = streetInput.text
         city = cityInput.text
        if (street == ""){
            validateOutput.text = "Please enter a street"
        }
        else if (city == ""){
            validateOutput.text = "Please enter a city"
        }else if (state == ""){
            validateOutput.text = "Please select a state"
        }
        else{
            let degree = degreeInput.titleForSegmentAtIndex(degreeInput.selectedSegmentIndex)
            if degree == "Celsius"{
                degreeVal = "si"
            }else{
                degreeVal = "us"
            }
            let targetAddress = "http://ioscs571-env.elasticbeanstalk.com/index.php?street=\(street!)&city=\(city!)&state=\(state)&degree=\(degreeVal)"
            print(targetAddress)
            getWeatherData(targetAddress)
        }
        /*
        * test w/ fake data
        */
//        street = "3460 w 7th st"
//        city = "los angeles"
//        state = "California"
//        
//        let degree = degreeInput.titleForSegmentAtIndex(degreeInput.selectedSegmentIndex)
//                    if degree == "Celsius"{
//                        degreeVal = "si"
//                    }else{
//                        degreeVal = "us"
//                    }
//        let targetAddress = "http://ioscs571-env.elasticbeanstalk.com/index.php?street=\(street!)&city=\(city!)&state=\(state)&degree=\(degreeVal)"
//        let tempAddress = "http://ioscs571-env.elasticbeanstalk.com/index.php?street=3460%20w%207th%20st&city=los%20angeles&state=California&degree=us"
//        getWeatherData(tempAddress)
    }
    
    @IBAction func clearInput(sender: AnyObject) {
        streetInput.text = ""
        cityInput.text = ""
        stateInput.setTitle("Select your state", forState: .Normal)
    }
    
    func parseResult(weatherData: NSData){
        do {
            if let tempjson = try NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as? NSDictionary {
                json = tempjson
                self.performSegueWithIdentifier("submit", sender: self)
            }
        } catch {
            print(error)
        }
        
    }
    
    func getWeatherData(urlString:String){
        let modifiedString = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url = NSURL(string: modifiedString!)
        print(url!)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) in
            dispatch_async(dispatch_get_main_queue(),{
                self.parseResult(data!)
            })
        }
        task.resume()
    }
    
     func userDidSelectState(info: NSString) {
        stateInput.setTitle(info as String, forState: .Normal)
        state = info as String
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "getState"){
            let nextCtrl: stateDetailTableViewController = segue.destinationViewController as! stateDetailTableViewController
            nextCtrl.delegate = self
        }
        
        if (segue.identifier == "submit"){
            let nextCtrl: ResultViewController = segue.destinationViewController as! ResultViewController
            print(testData)
            nextCtrl.json = json
            nextCtrl.degreeVal = degreeVal
            nextCtrl.city = city
            nextCtrl.state = state
            self.validateOutput.text = ""
            self.streetInput.text = ""
            self.cityInput.text = ""
            self.stateInput.setTitle("Select your state", forState: .Normal)
        }
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        streetInput.endEditing(true)
        cityInput.endEditing(true)
    }


}
