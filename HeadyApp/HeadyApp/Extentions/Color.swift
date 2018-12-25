//
//  File.swift
//  HeadyApp
//
//  Created by Apple on 25/12/18.
//  Copyright © 2018 HeadyApp. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Properties
public extension UIColor
{
    public class func AppBlueTextColor() -> UIColor{
        return UIColor(red:0.19, green:0.33, blue:0.77, alpha:1.0)
    }
    public class func AppGreenButtonColor() -> UIColor {
        return UIColor(red:0.22, green:0.80, blue:0.68, alpha:1.0)
        //return UIColor(red: 55.0/255.0, green: 204.0/255.0, blue: 174.0/255.0, alpha: 1.0)
    }
    public class func AppGreenButtonDisableColor() -> UIColor {
        return UIColor(red:0.61, green:0.93, blue:0.87, alpha:1.0)
        //return UIColor(red: 55.0/255.0, green: 204.0/255.0, blue: 174.0/255.0, alpha: 1.0)
    }
    public class func AppComponentsBorderColor() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    }
    public class func AppBorderGrayColor() -> UIColor {
        return UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
        //return UIColor(red:0.76, green:0.77, blue:0.77, alpha:1.0)
    }
    public class func AppOrangeColor() -> UIColor {
        //return UIColor.rgb(246.0/255.0,117.0/255.0,34.0/255.0)
        return UIColor(red:0.96, green:0.46, blue:0.13, alpha:1.0)
    }
    public class func AppIconsBlackColor() -> UIColor {
        // 2C3836
        return UIColor(red:0.17, green:0.22, blue:0.17, alpha:1.0)
    }
    public class func ProfileViewDescriptionTextColor() -> UIColor {
        return UIColor(red:0.59, green:0.61, blue:0.60, alpha:1.0)
    }
    public class func AboutReviewGrayBackground() -> UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
    }

    //UIColor(red:0.17, green:0.22, blue:0.21, alpha:1.0)
    /// SwifterSwift: Red component of UIColor (read-only).
    public var redComponent: Int {
        var red: CGFloat = 0.0
        getRed(&red, green: nil, blue: nil, alpha: nil)
        return Int(red * 255)
    }
    
    /// SwifterSwift: Green component of UIColor (read-only).
    public var greenComponent: Int {
        var green: CGFloat = 0.0
        getRed(nil, green: &green, blue: nil, alpha: nil)
        return Int(green * 255)
    }
    
    /// SwifterSwift: blue component of UIColor (read-only).
    public var blueComponent: Int {
        var blue: CGFloat = 0.0
        getRed(nil, green: nil, blue: &blue, alpha: nil)
        return Int(blue * 255)
    }
    
    /// SwifterSwift: Alpha of UIColor (read-only).
    public var alpha: CGFloat {
        var a: CGFloat = 0.0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    /// SwifterSwift: Hexadecimal value string (read-only).
    public var hexString: String {
        var red:    CGFloat = 0
        var green:    CGFloat = 0
        var blue:    CGFloat = 0
        var alpha:    CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0
        return NSString(format:"#%06x", rgb).uppercased as String
    }
    
    /// SwifterSwift: Short hexadecimal value string (read-only, if applicable).
    
    // can add colors according to text (There should be hexacode or rgb for proper implemenatation)
    class func colorWithName(_ name:String) -> UIColor{
        switch name {
        case "black":
            return .black
        case "lightgray":
            return .lightGray
        case "blue":
            return .blue
        case "red":
            return .red
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "brown":
            return .brown
        default:
            return .white
        }
    }
}

