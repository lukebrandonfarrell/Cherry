//
//  extensions .swift
//  Cherry
//
//  Created by Luke Farrell on 05/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

private var pauseStartKey:UInt8 = 0;
private var previousFireDateKey:UInt8 = 0;

extension NSTimer
{
    private var pauseStart: NSDate!{
        get{
            return objc_getAssociatedObject(self, &pauseStartKey) as? NSDate;
            
        }
        set(newValue)
        {
            objc_setAssociatedObject(self, &pauseStartKey,newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    private var previousFireDate: NSDate!{
        get{
            return objc_getAssociatedObject(self, &previousFireDateKey) as? NSDate;
            
        }
        set(newValue)
        {
            objc_setAssociatedObject(self, &previousFireDateKey,newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN);
        }
    }
    
    
    func pause()
    {
        pauseStart = NSDate();
        previousFireDate = self.fireDate;
        self.fireDate = NSDate.distantFuture() ;
    }
    
    func resume()
    {
        if(pauseStart != nil)
        {
            let pauseTime = -1 * pauseStart.timeIntervalSinceNow;
            let date = NSDate(timeInterval:pauseTime, sinceDate:previousFireDate );
            self.fireDate = date;
        }
        
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
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
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    func isiPad() -> Bool {
        if(modelName == "iPad 2" ||
           modelName == "iPad 3" ||
           modelName == "iPad 4" ||
           modelName == "iPad Air" ||
           modelName == "iPad Air 2" ||
           modelName == "iPad Mini" ||
            modelName == "iPad Mini 2" ||
            modelName == "iPad Mini 3" ||
            modelName == "iPad Mini 4" ||
            modelName == "iPad Pro"){
            return true;
        }else{
            return false;
        }
    }
}