//
//  Style.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

enum Style {
    enum Color {
        static let white: UIColor = .hex(0xffffff)
        static let darkGray: UIColor = .hex(0x353a41)
        static let lightGray: UIColor = .hex(0xb5bbc4)
        static let orange: UIColor = .hex(0xe68231)
        static let lightOrange: UIColor = .hex(0xf29c38)
        static let themeBlueColor: UIColor = .hex(0x0063f8)
    }

    enum Insets {
        static let `default`: CGFloat = 16
        static let paddingDefault: UIEdgeInsets = .init(
            top: Insets.default,
            left: Insets.default,
            bottom: Insets.default,
            right: Insets.default
        )
        static let cornerRadiusDefault: CGFloat = 8
    }

    enum Font {
        static let buttonText: UIFont = .systemFont(ofSize: 16)
    }
}
