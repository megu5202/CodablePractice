//
//  UIColor+Extensions.swift
//  CodableExample
//
//  Created by Melissa Guba on 11/8/17.
//  Copyright © 2017 Melissa Guba. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            let index = cString.characters.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red:(rgbValue >> 16) & 0xff, green:(rgbValue >> 8) & 0xff, blue:rgbValue & 0xff)
    }
    
    private convenience init(red: UInt32, green: UInt32, blue: UInt32) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
