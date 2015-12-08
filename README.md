# Using AerisWeatherMap in iOS9 with Swift
Basically following the installation guide on <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a>

## Details

1. Download the SDK <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a>

2. Obtain API access keys by <a href="http://www.aerisweather.com/support/docs/api/">registration</a>

3. Pick components of Aeris iOS SDK, for this assignment we can only use Aeris, AerisUI and AerisMap

4. Install <a href="https://github.com/AFNetworking/AFNetworking">AFNetworking 2.0</a> Using CocoaPods. AFNetworking is a required dependency for the Aeris iOS SDK and must be version 2.0 or higher.<br>
	4.1. Downloading AfNetworking <br>
	4.2. Install CocoaPods <br>
		4.2.1 Go to <a href="https://cocoapods.org/">CocoaPods</a> and follow the instruction to install it<br>
	4.3 Go to your project directory from terminal, then run the following command
		4.3.1 touch Podfile<br>
		4.3.2 open -a Xcode Podfile<br>
		4.3.3 copy folloing code into the Podfile<br>
			platform :ios, '7.0'<br>
			pod "AFNetworking", "~> 2.0"<br>
		4.3.4 pod install<br>
	4.4 After installing AFnetworking, closing current XCode project if it is open, then go to your working directory and open the xxx.xcworkspace just created<br>

5. Go back to the <a href="http://www.aerisweather.com/support/docs/toolkits/aeris-ios-sdk/">Aeris_IOS_SDK</a> tutorial and we are now in step5. Since now you should have the xcworkspace opened, ignore the first step in step5. <br>
	5.1 Drag Aeris.framework, AerisUI.framework and AerisMap.framework into your project in XCode. When prompted, select <b>Copy items into destination group’s folder</b>.<br>
