//
//  ForecastModule.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

final class ForecastModule {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    func inject() {
        container.register(ForecastViewModel.self) { _ in
            .init()
        }

        container.register(ForecastViewController.self) { resolver in
            .init(
                resolver.resolve(Coordinator.self)!,
                resolver.resolve(ForecastViewModel.self)!
            )
        }
    }
}
