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
        static let themeBlue: UIColor = .hex(0x0063f8)
        static let transparentBlue: UIColor = .hex(0x6298f7, alpha: 0.75)
        static let transparentWhite: UIColor = .hex(0xffffff, alpha: 0.75)
    }

    enum Insets {
        static let `default`: CGFloat = 16
        static let cornerRadiusDefault: CGFloat = 8
    }

    enum Font {
        static let buttonText: UIFont = .systemFont(ofSize: 16)
        static let searchInfoText: UIFont = .systemFont(ofSize: 14)
        static let searchAirportCodeText: UIFont = .systemFont(ofSize: 18, weight: .black)
        static let searchAirportInfoHeaderText: UIFont = .systemFont(ofSize: 18)
        static let airportAnnotationText: UIFont = .systemFont(ofSize: 20, weight: .medium)
    }
}
