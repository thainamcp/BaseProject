//
//  UIStackView.swift
//  TimelessTalkApp
//
//  Created by thainam on 15/03/2023.
//  Copyright © 2023 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    private func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}
