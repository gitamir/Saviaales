//
//  KeyboardBehavior.swift
//  Saviaales
//
//  Created by Amir Nuriev on 25.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class KeyboardBehavior {
    var action: ((_ frame: CGRect, _ options: UIView.AnimationOptions, _ duration: TimeInterval) -> Void)?
    var animations: ((_ frame: CGRect, _ options: UIView.AnimationOptions, _ duration: TimeInterval) -> Void)?
    var animationCompletion: ((Bool) -> Void)?

    func subscribe() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardSizeChanged),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    func unsubscribe() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    @objc func keyboardSizeChanged(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else {
            return
        }

        let options = UIView.AnimationOptions(rawValue: curve << 16)
        action?(frame, options, duration)

        if let animations = animations {
            UIView.animate(
                withDuration: duration,
                delay: 0,
                options: options,
                animations: {
                    animations(frame, options, duration)
                },
                completion: animationCompletion
            )
        }
    }
}

