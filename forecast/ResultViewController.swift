//
//  ResultViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 11/14/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import Social
import MobileCoreServices
import MapKit

class ResultViewController: UIViewController, FBSDKSharingDelegate{
    var json:NSDictionary!
    var city:String!
    var state:String!
    var degreeVal:String!
    var timeZone:String!
    var shareSummary:String!
    var shareTemp:String!
    var shareIcon:String!
    var latitudeValue:Double!
    var longtitudeValue:Double!
    @IBOutlet weak var ScrollPanel: UIScrollView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var tempratureUnitLabel: UILabel!
    @IBOutlet weak var highlowLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var dewpointLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollPanel.contentSize.height = 800
        parseDataForCurrentWeather(json)
        
        let aerisConsumerId = "66Z1M4b4Y0GYz2eZdczvp"
        let aerisConsumerSecret = "3H4DswGIEZgFPnKwdXWRRTs8mHpaTjsjocvn0mbN"
        AerisEngine.engineWithKey(aerisConsumerId, secret: aerisConsumerSecret)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FBpost(sender: AnyObject) {
            var shareTitle = ""
            shareTitle = "Current weather in "
            shareTitle += city + ", " + state
            var shareContent = ""
            shareContent += shareSummary
            shareContent += ", "
            shareContent += shareTemp
            shareContent += "\u{00B0}"
            if degreeVal == "si"{
                shareContent += "C"
            }else{
                shareContent += "F"
            }
            
            /*
            * construct content
            */
            let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
            content.contentURL = NSURL(string: "http://www.forecast.io")
            content.contentTitle = shareTitle
            content.contentDescription = shareContent
            let iconAddress = "http://xiaoran-hu.com/weatherIcons/" + shareIcon + ".imageset/" + shareIcon + ".png"
            content.imageURL = NSURL(string: iconAddress)
            
            /*
            * construct share dialog
            */
            let dialog:FBSDKShareDialog = FBSDKShareDialog()
            dialog.fromViewController = self
            dialog.shareContent = content
            dialog.mode = FBSDKShareDialogMode.FeedBrowser
            dialog.delegate = self
            dialog.show()
    }
    
    @IBAction func postFB2(sender: AnyObject) {
        let dialog: FBSDKShareDialog = FBSDKShareDialog()
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://forecast.io")
        content.contentTitle = "Share"
        content.contentDescription = "helloworld"
        content.imageURL = NSURL(string: "http://cs-server.usc.edu:45678/hw/hw8/images/wind.png")
        dialog.shareContent = content
        dialog.show()
        
    }

    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        if (results.count > 0) {
            let alert = UIAlertController(title: "Success", message: "You have sucessfully shared", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Cancel", message: "You have cancelled your share", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("error !!")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("cancel !!")
    }
    
    func parseDataForCurrentWeather(json: NSDictionary){
        var summaryContent = ""
        var tempratureContent = ""
        var tempratureUnitContent = ""
        var lowhighContent = ""
        var precipitationContent = ""
        var rainContent = ""
        var windspeedContent = ""
        var dewpointContent = ""
        var humidityContent = ""
        var visibilityContent = ""
        var sunrise = ""
        var sunset = ""
        
        timeZone = json["timezone"] as? String
        latitudeValue = json["latitude"] as? Double
        longtitudeValue = json["longitude"] as? Double
        
        print("location is \(latitudeValue) , \(longtitudeValue)")
        /*
        * current info
        */
        if let currently = json["currently"] as? NSDictionary{
            
            // ------- 1 ---------    current summary
            if let summary = currently["summary"] as? String{
                summaryContent += summary
                shareSummary = summary
            }
            summaryContent += " in "
            summaryContent += city
            summaryContent += ", "
            summaryContent += state
            summaryLabel.text = summaryContent
            
            // ------- 2 ---------   current temp
            if let temprature = currently["temperature"] as? Double{
                tempratureContent = String(Int(temprature))
                shareTemp = String(Int(temprature))
            }
            tempratureLabel.text = tempratureContent
            
            // ------- 3 ---------   current temp symbol & degree
            tempratureUnitContent += "\u{00B0}"
            if degreeVal == "si"{
                tempratureUnitContent += "C"
            }else{
                tempratureUnitContent += "F"
            }
            tempratureUnitLabel.text = tempratureUnitContent
            
            
            // ------- 4 ---------    low high temp
            if let daily = json["daily"] as? NSDictionary{
                if let dailydata = daily["data"] as? NSArray{
                    if let dailyData0 = dailydata[0] as? NSDictionary{
                        lowhighContent += "L:"
                        if let tempHigh = dailyData0["temperatureMin"] as? Double{
                            lowhighContent += String(Int(tempHigh))
                        }
                        lowhighContent += "\u{00B0} | H:"
                        if let tempLow = dailyData0["temperatureMax"] as? Double{
                            lowhighContent += String(Int(tempLow))
                        }
                        lowhighContent += "\u{00B0}"
                    }
                }
            }
            highlowLabel.text = lowhighContent
            
            
            // ------- 5 ---------  precipitation
            if let precipitation = currently["precipIntensity"] as? Double{
                if precipitation >= 0 && precipitation < 0.002{
                    precipitationContent += "None"
                }else if precipitation >= 0.002 && precipitation < 0.017{
                    precipitationContent += "Very Light"
                }else if precipitation >= 0.017 && precipitation < 0.1{
                    precipitationContent += "Light"
                }else if precipitation >= 0.1 && precipitation < 0.4{
                    precipitationContent += "Moderate"
                }else{
                    precipitationContent += "Heavy"
                }
            }
            precipitationLabel.text = precipitationContent
            
            // ------- 6 ---------  rain possibility
            if let rainPoss = currently["precipProbability"] as? Double{
                rainContent += String(Int(rainPoss*100))
                rainContent += "%"
            }
            rainLabel.text = rainContent
            
            
            // ------- 7 ---------  wind speed
            if let windspeed = currently["windSpeed"] as? Double{
                windspeedContent += String(windspeed)
                if degreeVal == "si"{
                    windspeedContent += " m/s"
                }else{
                    windspeedContent += " mph"
                }
            }
            speedLabel.text = windspeedContent
            
            // ------- 8 ---------  Dew Point
            if let dewpoint = currently["dewPoint"] as? Double{
                dewpointContent += String(Int(round(dewpoint)))
                dewpointContent += " \u{00B0}"
                if degreeVal == "si"{
                    dewpointContent += "C"
                }else{
                    dewpointContent += "F"
                }
            }
            dewpointLabel.text = dewpointContent
            
            // ------- 9 ---------  humidity
            if let humidity = currently["humidity"] as? Double{
                humidityContent += String(Int(humidity*100))
                humidityContent += " %"
            }
            humidityLabel.text = humidityContent
            
            // ------- 10 ---------  visibility
            if let visibility = currently["visibility"] as? Double{
                visibilityContent += String(round(visibility*100)/100)
                if degreeVal == "si"{
                    visibilityContent += " KM"
                }else{
                    visibilityContent += " Mi"
                }
            }
            visibilityLabel.text = visibilityContent
            
            
            // ------- 11 ---------  sunrise & sunset time
            if let daily = json["daily"] as? NSDictionary{
                if let dailydata = daily["data"] as? NSArray{
                    if let dailyData0 = dailydata[0] as? NSDictionary{
                        if let sunriseTimestamp = dailyData0["sunriseTime"] as? Double{
                            let date = NSDate(timeIntervalSince1970:sunriseTimestamp)
                            let formatter = NSDateFormatter()
                            formatter.dateFormat = "H:mm a"
                            formatter.timeZone = NSTimeZone(name: timeZone)
                            let sunriseTime = formatter.stringFromDate(date)
                            sunrise = sunriseTime
                        }
                        if let sunsetTimestamp = dailyData0["sunsetTime"] as? Double{
                            let date = NSDate(timeIntervalSince1970:sunsetTimestamp)
                            let formatter = NSDateFormatter()
                            formatter.dateFormat = "H:mm a"
                            formatter.timeZone = NSTimeZone(name: timeZone)
                            let sunsetTime = formatter.stringFromDate(date)
                            sunset = sunsetTime
                        }
                    }
                }
            }
            sunriseLabel.text = sunrise
            sunsetLabel.text = sunset
            
            
            
            // ------- 12 ---------  image
            if let icon = currently["icon"] as? String{
                iconImage.image = UIImage(named: icon)
                shareIcon = icon
            }
            
        }
        
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "details"{
            let nextCtrl:DetailsViewController = segue.destinationViewController as! DetailsViewController
            nextCtrl.json = json
            nextCtrl.degreeVal = degreeVal
        }
        
        if segue.identifier == "showMap"{
            let nextCtrl:MapViewController = segue.destinationViewController as! MapViewController
            nextCtrl.latitudeValue = latitudeValue
            nextCtrl.longtitudeValue = longtitudeValue
            nextCtrl.cityValue = city
        }
    }


}
