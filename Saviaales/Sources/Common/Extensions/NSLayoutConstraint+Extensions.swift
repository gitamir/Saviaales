//
//  NSLayoutConstraint+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    class func pinToSuperview(view: UIView, with insets: UIEdgeInsets = .zero) {
        guard let superview = view.superview else { return }

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            superview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
            superview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ])
    }
}
