//
//  UIButton+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        setBackgroundImage(
            UIImage.solid(color: color, size: UIScreen.main.bounds.size),
            for: state
        )
    }
}
