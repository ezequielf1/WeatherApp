//
//  ManualRender.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

protocol ManualRender {
    func get<T: UIView>(owner: Any?, container: UIView?) -> T
}

extension ManualRender where Self: UIView {
    func get<T: UIView>(owner: Any?, container: UIView? = nil) -> T {
        guard let customView = Bundle.main.loadNibNamed(String(describing: T.self),
                                                        owner: owner,
                                                        options: nil)?.first as? T else {
            fatalError("Couldn't load a nib named " + String(describing: T.self))
        }
        if let container = container {
            clearSubviews(from: container)
            customView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(customView)
            addConstraint(containerView: container, customView: customView)
        }
        return customView
    }

    func attachView(container: UIView? = nil) {
        if let container = container {
            clearSubviews(from: container)
            self.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(self)
            addConstraint(containerView: container, customView: self)
        }
    }

    private func addConstraint(containerView: UIView?, customView: UIView?) {
        guard let containerView = containerView, let customView = customView else { return }

        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: containerView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    private func clearSubviews(from view: UIView) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
}

