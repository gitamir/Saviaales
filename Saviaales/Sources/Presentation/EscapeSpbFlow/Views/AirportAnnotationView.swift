//
//  AirportAnnotationView.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import MapKit

class AirportAnnotationView: MKAnnotationView {
    private enum Constants {
        static let size: CGSize = .init(width: 100, height: 50)
        static let borderWidth: CGFloat = 3
    }

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Color.transparentWhite
        view.layer.borderColor = Style.Color.transparentBlue.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.size.height / 2
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Style.Font.airportAnnotationText
        label.textColor = Style.Color.transparentBlue
        return label
    }()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }

    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(label)
        containerView.frame = CGRect(origin: .zero, size: Constants.size)
        containerView.center = center
        label.frame = containerView.bounds
    }

    func update(with airport: Airport) {
        label.text = airport.iata
    }
}
