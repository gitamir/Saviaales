//
//  UIImage+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension UIImage {
    class func customDraw(size: CGSize, _ drawing: (CGContext) -> Void) -> UIImage {
        return customDraw(size: size, opaque: true, drawing)
    }

    class func customDraw(size: CGSize, opaque: Bool, _ drawing: (CGContext) -> Void) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError()
        }

        drawing(context)

        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError()
        }
        return image
    }

    class func solid(color: UIColor, size: CGSize) -> UIImage {
        return customDraw(size: size) { context in
            color.setFill()
            context.addRect(CGRect(origin: .zero, size: size))
            context.drawPath(using: .fill)
        }
    }
}
