//
//  CustomNavigationController.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
