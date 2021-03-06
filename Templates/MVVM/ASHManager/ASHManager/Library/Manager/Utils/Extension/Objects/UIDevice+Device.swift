//
//  Device.swift
//  ASHManager
//
//  Created by PhanDuyHai on 12/22/17.
//  Copyright © 2017 Asahi. All rights reserved.
//

/*
 ============================> IOS App memory usage standards <============================ 

If you are targeting iOS 10 the lowest memory capability mobile device your app will be run on will be 512mb of RAM (iPhone 4s). The given "point of worry" for memory usage for this device would be around the ~170 / 180mb range.

Here are some crash stats for devices (RAM Usage @ Crash / Total Memory Limit of device):

iPad1: 127MB/256MB/49%

iPad2: 275MB/512MB/53%

iPad3: 645MB/1024MB/62%

iPad4: 585MB/1024MB/57% (iOS 8.1)

iPad Mini 1st Generation: 297MB/512MB/58%

iPad Mini retina: 696MB/1024MB/68% (iOS 7.1)

iPad Air: 697MB/1024MB/68%

iPad Air 2: 1195MB/2048MB/58% (iOS 8.x)

iPad Pro 12.9: 3064MB/3981MB/77% (iOS 9.3.2)

iPad Pro 9.7": 1395MB/1971MB/71% (iOS 10.0.2 (14A456))

iPod touch 4th gen: 130MB/256MB/51% (iOS 6.1.1)

iPod touch 5th gen: 286MB/512MB/56% (iOS 7.0)

iPhone4: 325MB/512MB/63%

iPhone4S: 286MB/512MB/56%

iPhone5: 645MB/1024MB/62%

iPhone5S: 646MB/1024MB/63%

iPhone6: 645MB/1024MB/62% (iOS 8.x)

iPhone6+: 645MB/1024MB/62% (iOS 8.x)

iPhone6s: 1396MB/2048MB/68% (iOS 9.2)

iPhone6s+: 1195MB/2048MB/58% (theoretical, untested)

iPhoneSE: 1395MB/2048MB/69% (iOS 9.3)

iPhone7+: 2040MB/3072MB/66% (iOS 10.2.1)
*/

import Localize_Swift

class Device {
	// Size
	static let screenHeight = UIScreen.main.bounds.size.height
	static let screenWidth = UIScreen.main.bounds.size.width
	static let originalMaxWidth = 640.0
	
	// Type
	static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
	static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
	static let isRetina = (UIScreen.main.scale >= 2.0)
	static let screenMaxLength = (max(screenWidth, screenHeight))
	static let screenMinLength = (min(screenWidth, screenHeight))
	static let isIphone4OrLess = (isIphone && screenMaxLength < 568.0)
	static let isIphone5 = (isIphone && screenMaxLength == 568.0)
	static let isIphone6 = (isIphone && screenMaxLength == 667.0)
	static let isIphone6Plus = (isIphone && screenMaxLength == 736.0)
	
	// General
	static let osName = UIDevice.current.name
	static let osVersion = UIDevice.current.systemVersion
	static let modelName = UIDevice.modelName
	static let modelUUID = UIDevice.current.identifierForVendor!.uuidString
	static var timezone: String {
		get {
			let localTimeZoneFormatter = DateFormatter()
			localTimeZoneFormatter.timeZone = TimeZone.autoupdatingCurrent
			localTimeZoneFormatter.dateFormat = "Z"
			return localTimeZoneFormatter.string(from: Date())
		}
	}
	
	// Check Language
	static let isJapanLanguage = Localize.currentLanguage() == "ja"
	static let isVietNamLanguage = Localize.currentLanguage() == "vn"
	static let isEnglishLanguage = Localize.currentLanguage() == "en"
}

// MARK: - ================================= Private =================================
private extension UIDevice {
	static let modelName: String = {
		var systemInfo = utsname()
		uname(&systemInfo)
		let machineMirror = Mirror(reflecting: systemInfo.machine)
		let identifier = machineMirror.children.reduce("") { identifier, element in
			guard let value = element.value as? Int8, value != 0 else { return identifier }
			return identifier + String(UnicodeScalar(UInt8(value)))
		}
		
		func mapToDevice(identifier: String) -> String { 
			#if os(iOS)
			switch identifier {
			case "iPod5,1":                                 return "iPod Touch 5"
			case "iPod7,1":                                 return "iPod Touch 6"
			case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
			case "iPhone4,1":                               return "iPhone 4s"
			case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
			case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
			case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
			case "iPhone7,2":                               return "iPhone 6"
			case "iPhone7,1":                               return "iPhone 6 Plus"
			case "iPhone8,1":                               return "iPhone 6s"
			case "iPhone8,2":                               return "iPhone 6s Plus"
			case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
			case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
			case "iPhone8,4":                               return "iPhone SE"
			case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
			case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
			case "iPhone10,3", "iPhone10,6":                return "iPhone X"
			case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
			case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
			case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
			case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
			case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
			case "iPad6,11", "iPad6,12":                    return "iPad 5"
			case "iPad7,5", "iPad7,6":                      return "iPad 6"
			case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
			case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
			case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
			case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
			case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
			case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
			case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
			case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
			case "AppleTV5,3":                              return "Apple TV"
			case "AppleTV6,2":                              return "Apple TV 4K"
			case "AudioAccessory1,1":                       return "HomePod"
			case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
			default:                                        return identifier
			}
			#elseif os(tvOS)
			switch identifier {
			case "AppleTV5,3": return "Apple TV 4"
			case "AppleTV6,2": return "Apple TV 4K"
			case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
			default: return identifier
			}
			#endif
		}
		
		return mapToDevice(identifier: identifier)
	}()
}
