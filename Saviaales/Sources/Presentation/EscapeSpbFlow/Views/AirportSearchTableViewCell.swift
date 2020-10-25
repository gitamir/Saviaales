//
//  AirportSearchTableViewCell.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class AirportSearchTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var airportNameLabel: UILabel!
    @IBOutlet private var iataCodeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = Style.Color.lightGray
        nameLabel.font = Style.Font.searchInfoText
        nameLabel.textColor = Style.Color.white
        airportNameLabel.font = Style.Font.searchInfoText
        airportNameLabel.textColor = Style.Color.white
        iataCodeLabel.font = Style.Font.searchAirportCodeText
        iataCodeLabel.textColor = Style.Color.darkGray
    }

    func update(with airport: Airport) {
        nameLabel.text = airport.name
        airportNameLabel.text = airport.airportName
        iataCodeLabel.text = airport.iata
    }
}
