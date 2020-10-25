//
//  SelectDestinationAirportViewController.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class SelectDestinationAirportViewController: UIViewController {
    struct Input {
        let departureAirport: String
        let isFlightPossible: () -> Bool
    }

    struct Output {
        let selectDestinationAirport: (@escaping (String) -> Void) -> Void
        let showFlightScreen: () -> Void
    }

    var input: Input!
    var output: Output!

    @IBOutlet private var buttonsStackView: UIStackView!
    @IBOutlet private var ctaButton: UIButton!
    private weak var destinationAirportView: AirportSelectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Style.Color.themeBlueColor
        let departureAirportView = AirportSelectionView()
        departureAirportView.update(
            with: .init(type: .top, state: .inactive(text: input.departureAirport))
        )
        let destinationAirportView = AirportSelectionView()
        destinationAirportView.update(
            with: .init(
                type: .bottom,
                state: .active(
                    action: { [weak self] in
                        self?.selectAirportTap()
                    },
                    text: "select_destination_selector_placeholder".localized
                )
            )
        )
        self.destinationAirportView = destinationAirportView
        buttonsStackView.addArrangedSubview(departureAirportView)
        buttonsStackView.addArrangedSubview(destinationAirportView)
        ctaButton.layer.masksToBounds = true
        ctaButton.layer.cornerRadius = Style.Insets.cornerRadiusDefault
        ctaButton.setTitleColor(Style.Color.white, for: .normal)
        ctaButton.titleLabel?.font = Style.Font.buttonText
        ctaButton.setTitle("select_destination_cta_button_title".localized, for: .normal)
        ctaButton.setBackgroundColor(Style.Color.lightOrange, for: .highlighted)
        ctaButton.setBackgroundColor(Style.Color.orange, for: .normal)
        ctaButton.setBackgroundColor(Style.Color.lightGray, for: .disabled)
        ctaButton.isEnabled = input.isFlightPossible()
    }

    private func updateDestination(_ destination: String) {
        destinationAirportView?.update(
            with: .init(
                type: .bottom,
                state: .active(
                    action: { [weak self] in
                        self?.selectAirportTap()
                    },
                    text: destination
                )
            )
        )
    }

    private func selectAirportTap() {
        output.selectDestinationAirport { [weak self] destinationAirport in
            guard let self = self else { return }

            self.ctaButton.isEnabled = self.input.isFlightPossible()
            self.updateDestination(destinationAirport)
        }
    }


    @IBAction private func ctaButtonTap(_ sender: UIButton) {
        output.showFlightScreen()
    }
}
