//
//  MapViewController.swift
//  forecast
//
//  Created by xiaoran.hu on 12/7/15.
//  Copyright © 2015 xiaoran.hu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var latitudeValue:Double!
    var longtitudeValue:Double!
    var cityValue:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(
            latitude: latitudeValue,
            longitude: longtitudeValue
        )
        
//        let span = MKCoordinateSpanMake(0.5, 0.5)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = cityValue
//        mapView.addAnnotation(annotation)


        let weatherMap:AWFWeatherMap = AWFWeatherMap.init(mapType: AWFWeatherMapType.Apple)
        weatherMap.setMapCenterCoordinate(location, zoomLevel: 13, animated: true)
        weatherMap.weatherMapView.frame = self.view.bounds
        weatherMap.addLayerType(AWFLayerType.RadarSatellite)
        weatherMap.config.animationEnabled = true
        self.view.addSubview(weatherMap.weatherMapView)
        
//        let weatherMapController:AWFWeatherMapViewController = AWFWeatherMapViewController()
//        weatherMapController.weatherMapType = AWFWeatherMapType.Apple
        
//
        
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
