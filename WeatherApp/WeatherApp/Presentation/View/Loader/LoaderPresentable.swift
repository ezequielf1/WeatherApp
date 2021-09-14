//
//  LoaderPresentable.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

protocol LoaderPresentable {}

extension LoaderPresentable {
    func showLoader() {
        Loader.shared.show()
    }

    func hideLoader() {
        Loader.shared.hide()
    }
}
