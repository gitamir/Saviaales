//
//  AppCoordinator.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let container: DependencyContainer

    init(window: UIWindow, container: DependencyContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        let escapeSpbFlow = EscapeSpbFlow { rootViewController in
            self.window.rootViewController = rootViewController
            self.window.makeKeyAndVisible()
        }
        container.resolve(escapeSpbFlow)
        escapeSpbFlow.start()
    }
}
