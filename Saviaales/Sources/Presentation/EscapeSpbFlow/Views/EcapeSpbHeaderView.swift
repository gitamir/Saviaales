//
//  EcapeSpbHeaderView.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class EscapeSpbHeaderView: UIView {
    private let planeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-plane-default"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Style.Color.white
        return imageView
    }()

    private let horsemanImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-horseman")?.withHorizontallyFlippedOrientation())
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Style.Color.white
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupUI()
    }

    private func setupUI() {
        backgroundColor = .clear
        planeImageView.translatesAutoresizingMaskIntoConstraints = false
        horsemanImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(planeImageView)
        addSubview(horsemanImageView)
        NSLayoutConstraint.activate([
            horsemanImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horsemanImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            horsemanImageView.heightAnchor.constraint(equalTo: heightAnchor),
            planeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2 * Style.Insets.default),
            planeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            planeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
        ])
    }
}
