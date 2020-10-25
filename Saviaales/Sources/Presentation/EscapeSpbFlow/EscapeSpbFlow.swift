//
//  EscapeSpbFlow.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

final class EscapeSpbFlow: AirportsServiceDependency {
    var airportsService: AirportsService!
    private let onRootViewControllerCreated: (UIViewController) -> Void
    private weak var navigationController: UINavigationController?

    init(onRootViewControllerCreated: @escaping (UIViewController) -> Void) {
        self.onRootViewControllerCreated = onRootViewControllerCreated
    }

    func start() {
        let initialViewController = createSelectDestinationViewController()
        let navigationController = CustomNavigationController(rootViewController: initialViewController)
        self.navigationController = navigationController
        onRootViewControllerCreated(navigationController)
    }

    private func createSelectDestinationViewController() -> UIViewController {
        let viewController: SelectDestinationAirportViewController = .instantiateFromSameNamedStoryboard()
        viewController.input = .init(
            departureAirport: airportsService.departureAirport.iata,
            isFlightPossible: { self.airportsService.isFlightPossible }
        )
        viewController.output = .init(
            selectDestinationAirport: showSearchAirportsViewController(_:),
            showFlightScreen: {}
        )
        return viewController
    }

    private func showSearchAirportsViewController(_ selectAirportCompletion: @escaping (String) -> Void) {
        guard let navigationController = navigationController else { return }

        let viewController: SearchAirportsViewController = .instantiateFromSameNamedStoryboard()
        viewController.input = .init(
            lastUsedIATA: airportsService.destinationAirport?.iata,
            searchAirports: airportsService.getAirports
        )
        viewController.output = .init(
            selectAirport: { airport in
                self.airportsService.destinationAirport = airport
                selectAirportCompletion(airport.iata)
                self.navigationController?.popViewController(animated: true)
            }
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
