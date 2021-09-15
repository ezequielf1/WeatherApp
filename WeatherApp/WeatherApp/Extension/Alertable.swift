//
//  Alertable.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

protocol Alertable {
    func showAlert(title: String, message: String, actionTitle: String, onActionCompletion: (() -> Void)?)
}

extension Alertable where Self: UIViewController {
    func showAlert(title: String = L10n.appName,
                   message: String,
                   actionTitle: String = L10n.ok,
                   onActionCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle,
                                      style: .default,
                                      handler: { _ in onActionCompletion?() }))
        present(alert, animated: true)
    }
}
