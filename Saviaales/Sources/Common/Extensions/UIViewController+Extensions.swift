//
//  UIViewController+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension UIViewController {
    private class func instantiateViewController<T: UIViewController>(
        from storyboard: UIStoryboard,
        identifier: String
    ) -> T {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Error instantiating view controller with identifier \(identifier)")
        }
        return viewController
    }


    class func instantiate(from storyboard: UIStoryboard, identifier: String) -> Self {
        return instantiateViewController(from: storyboard, identifier: identifier)
    }

    class func instantiateFromSameNamedStoryboard() -> Self {
        let identifier = String(describing: self)
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: identifier, bundle: bundle)
        return instantiate(from: storyboard, identifier: identifier)
    }

    func showAlert(withTitle title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
