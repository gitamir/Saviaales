//
//  UIColor+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension UIColor {
    class func hex(_ value: UInt, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((value & 0xff0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00ff00) >> 8) / 255.0,
            blue: CGFloat((value & 0x0000ff) >> 0) / 255.0,
            alpha: alpha
        )
    }

    class func rgb(_ red: UInt, _ green: UInt, _ blue: UInt, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
}
