//
//  UITableViewCell+Extensions.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

extension UITableViewCell {
    class func registerNib(in tableView: UITableView) {
        let name = "\(self)"
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: name)
    }

    class func registerClass(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: "\(self)")
    }

    private class func dequeueCell<T: UITableViewCell>(from tableView: UITableView, for indexPath: IndexPath) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(self)", for: indexPath) as? T else {
            fatalError("Error dequeuing cell for index path \(indexPath)")
        }
        return cell
    }

    class func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return dequeueCell(from: tableView, for: indexPath)
    }
}
