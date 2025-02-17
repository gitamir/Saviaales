//
//  AppDelegate.swift
//  Saviaales
//
//  Created by Amir Nuriev on 23.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let container = ContainerFactory(baseUrl: "http://places.aviasales.ru/").makeContainer(.escapeSpbDefault)
        let appCoordinator = AppCoordinator(window: window, container: container)
        appCoordinator.start()
        return true
    }
}
