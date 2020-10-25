//
//  Debouncer.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import Foundation

class Debouncer {
    private let timeInterval: TimeInterval
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?

    init(timeInterval: TimeInterval, queue: DispatchQueue) {
        self.timeInterval = timeInterval
        self.queue = queue
    }

    deinit {
        cancel()
    }

    func debounce(action: @escaping () -> Void) {
        cancel()
        let workItem = DispatchWorkItem { [weak self] in
            action()
            self?.workItem = nil
        }
        self.workItem = workItem
        queue.asyncAfter(deadline: .now() + timeInterval, execute: workItem)
    }

    func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}
