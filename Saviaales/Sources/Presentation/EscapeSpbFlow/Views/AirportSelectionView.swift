//
//  AirportSelectionView.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class AirportSelectionView: UIView {
    struct AirportSelectionViewModel {
        enum SelectionViewType {
            case top
            case middle
            case bottom
        }

        enum State {
            case active(action: (() -> Void), text: String)
            case inactive(text: String)

            var action: (() -> Void)? {
                switch self {
                    case .active(action: let action, _):
                        return action
                    case .inactive:
                        return nil
                }
            }

            var buttonText: String {
                switch self {
                    case .inactive(let text), .active(_, let text):
                        return text
                }
            }

            var isEnabled: Bool {
                switch self {
                    case .active:
                        return true
                    case .inactive:
                        return false
                }
            }
        }

        let type: SelectionViewType
        let state: State
    }

    private var action: (() -> Void)?
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Style.Color.white
        button.titleLabel?.font = Style.Font.buttonText
        button.setTitleColor(Style.Color.darkGray, for: .normal)
        button.setTitleColor(Style.Color.lightGray, for: .disabled)
        button.setBackgroundColor(Style.Color.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        return button
    }()

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }

    private func setupUI() {
        backgroundColor = Style.Color.white
        layer.masksToBounds = true
        layer.cornerRadius = Style.Insets.cornerRadiusDefault
        addSubview(button)
        NSLayoutConstraint.pinToSuperview(view: button)
    }

    func updateWithViewModel(_ viewModel: AirportSelectionViewModel) {
        self.action = viewModel.state.action
        button.setTitle(viewModel.state.buttonText, for: .normal)
        button.isEnabled = viewModel.state.isEnabled
        let maskedCorners: CACornerMask
        switch viewModel.type {
            case .top:
                maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner ]
            case .middle:
                maskedCorners = []
            case .bottom:
                maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        }
        layer.maskedCorners = maskedCorners
    }

    @objc private func buttonTap(_ sender: UIButton) {
        action?()
    }
}
