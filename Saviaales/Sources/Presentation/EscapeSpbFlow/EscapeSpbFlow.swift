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
        let viewController = SelectDestinationAirportViewController()
        let navigationController = CustomNavigationController(rootViewController: viewController)
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
}
