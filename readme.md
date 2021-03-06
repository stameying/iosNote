# Using AerisWeatherMap in iOS9 with Swift
Basically following the installation guide on <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a>
	

## Details

1. Download the SDK <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a>

2. Obtain API access keys by <a href="http://www.aerisweather.com/support/docs/api/">registration</a> and registering an new App and then you can find the Key. (when registering, the namespace should be same to the one in your project)

3. Pick components of Aeris iOS SDK, for this assignment we can only use Aeris, AerisUI and AerisMap

4. Install <a href="https://github.com/AFNetworking/AFNetworking">AFNetworking 2.0</a> Using CocoaPods. AFNetworking is a required dependency for the Aeris iOS SDK and must be version 2.0 or higher
	1. Install CocoaPods <br>
		a. Go to <a href="https://cocoapods.org/">CocoaPods</a> and follow the instruction to install it<br>
	2. Go to your project directory from terminal, then run the following command.<br>
		1. touch Podfile<br>
		2. open -a Xcode Podfile<br>
		3. copy folloing code into the Podfile, ios '7.0' here works for me and you can try to replace it by 9.0
		
		```
			platform :ios, '7.0'
			pod "AFNetworking", "~> 2.0"
		```
		4. pod install		
	3. After installing AFnetworking, closing current XCode project if it is open, then go to your working directory and open the xxx.xcworkspace just created<br>

5. Go back to the <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a> tutorial and we are now in step5. 
	1. Skipped. (Since we should have the xcworkspace opened alreadt. )
	2. Drag Aeris.framework, AerisUI.framework and AerisMap.framework into your project in XCode. When prompted, select <b>Copy items into destination group’s folder</b>.
	3. Same to 3 under step5 of <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a> 
	4. Same to 4 
	5. Same to 5
	6. Same to 6
	7. Creating Bridge header for our swift project <a href="https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html">Swift and Objective-C in the Same Project</a>
		1. click new file -> file -> Header in Xcode
		2. name of the header file: FileyourProjectName-Bridging-Header.h (i.e. test-Bridging-Header.h)
		3. open the bridge header we just create, add the required header files by copying and pasting the three lines from 7 under step 5 (<a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris ios sdk</a>), which should look like #import <Aeris/Aeris.h> ...
		4. in Building Setting, the one next to Building Phases, in Swift Compiler - Code Generation, add the bridging header file path. If it is under the root of your project, it should be similar to "test-Bridging-Header" (don't put "" into it)
	8. Try build the project and there should be no error. Check below if you see some error. If there is no error
		1. Go to the viewController where you want to use the map. 
		2. 
		```
		let aerisConsumerId = "Your id goes here"
        let aerisConsumerSecret = "your secret number goes here"
        AerisEngine.engineWithKey(aerisConsumerId, secret: aerisConsumerSecret)
        ```
		3. build to see if there is error
		
6. Adding AWFWeather Map <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/getting-started/weather-maps/">Aeris WeatherMap</a>
			
```
    	let weatherMap:AWFWeatherMap = AWFWeatherMap.init(mapType: AWFWeatherMapType.Apple)
        // you can set center by weatherMap.setMapCenterCoordinate
        weatherMap.weatherMapView.frame = self.view.bounds
        self.view.addSubview(weatherMap.weatherMapView)                        
    	// you can later add layer by weather.addLayerType()
```

## Build Error
	"Undefined symbols for architecture arm64":
	
	1. Go back to 6 under step5
	2. add $(inherited) to the Other Linker Flags.
		
			
## Contact

 	E-mail:huxiaora@usc.edu

		
## Note:

I'm new to Swift and IOS development. This stuff
	takes me  1-2 days to figure it out, so I write this 	down to help people who might be new as well and try 	to use Embed Aeris Weather Map into their swift 	project.
		
		
		
			
		
		