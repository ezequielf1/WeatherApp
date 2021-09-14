//
//  UIViewExtension.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(owner: Any?, bundle: Bundle = .main) -> T {
        guard let view = bundle.loadNibNamed(String(describing: self),
                                             owner: owner, options: nil)?.first as? T else {
            fatalError("error loading LoaderView.\n\(#file)\n\(#line)")
        }
        return view
    }

    func roundCorners(
        corners: CACornerMask = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner
        ],
        radius: CGFloat
    ) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }

    @objc
    func onClick(cancelsTouchesInView: Bool = true, _ onClick: @escaping () -> Void) {
        let clickableGestureRecognizer = ClickableGestureRecognizer(
            onClick: onClick,
            target: self,
            action: #selector(callListener(_:)),
            cancelsTouchesInView: cancelsTouchesInView
        )
        addGestureRecognizer(clickableGestureRecognizer)
    }

    @objc private func callListener(_ sender: ClickableGestureRecognizer) {
        sender.onClick()
    }
}
