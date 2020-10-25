//
//  UIView+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension UIView {
    private class func viewInNibNamed<T: UIView>(_ nibNamed: String) -> T {
        guard let view = Bundle.main.loadNibNamed(nibNamed, owner: nil, options: nil)?.first as? T else {
            fatalError("Error loading view from nib \(nibNamed)")
        }
        return view
    }

    class func nib() -> Self {
        return viewInNibNamed(String(describing: self))
    }

    class func nib(_ frame: CGRect) -> Self {
        let view = nib()
        view.frame = frame
        view.layoutIfNeeded()
        return view
    }
}
