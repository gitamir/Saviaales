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
    private var trolololo: Bool = false

    init(onRootViewControllerCreated: @escaping (UIViewController) -> Void) {
        self.onRootViewControllerCreated = onRootViewControllerCreated
    }

    func start() {
        let initialViewController = createSelectDestinationViewController()
        let navigationController = CustomNavigationController(rootViewController: initialViewController)
        self.navigationController = navigationController
        onRootViewControllerCreated(navigationController)
        airportsService.getAirports(for: "paris") { result in
            switch result {
                case .success(let airports):
                    self.trolololo = true
                    print(airports.debugDescription)
                case .failure(let error):
                    self.trolololo = false
                    print(error.localizedDescription)
            }
        }
    }

    private func createSelectDestinationViewController() -> UIViewController {
        let viewController: SelectDestinationAirportViewController = .instantiateFromSameNamedStoryboard()
        viewController.input = .init(departureAirport: "LED")
        viewController.output = .init(
            selectDestinationAirport: { completion in
                print("show select destination")
            },
            showFlightScreen: {
                print("show flight screen")
            }
        )
        return viewController
    }
}
