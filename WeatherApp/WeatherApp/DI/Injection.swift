//
//  Injection.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

final class Injection {

    static let shared = Injection()

    private let container = Container()
    private let mainModule: MainModule

    private init() {
        mainModule = MainModule(container)
        injectDependencies()
    }

    func getNavigationController() -> UINavigationController {
        return mainModule.getNavigationController()
    }

    private func injectDependencies() {
        TodayModule(container).inject()
        ForecastModule(container).inject()
        mainModule.inject()
    }
}
