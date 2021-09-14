//
//  Loader.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//
import UIKit

final class Loader {
    static let shared = Loader()
    private(set) var isBeingShown: Bool
    private var loaderView: PresentableLoader?

    init() {
        self.isBeingShown = false
    }

    func show() {
        guard !isBeingShown else { return }
        isBeingShown.toggle()
        loaderView = LoaderView()
        loaderView?.show()
    }

    func hide() {
        guard isBeingShown else { return }
        isBeingShown.toggle()
        loaderView?.hide()
    }
}
