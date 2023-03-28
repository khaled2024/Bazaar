//
//  UiStackView+AddArrangedViews.swift
//  Bazaar
//
//  Created by KhaleD HuSsien on 17/03/2023.
//

import UIKit
extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
