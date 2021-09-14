//
//  MainModule.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

final class MainModule {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    func inject() {
        container.register(Coordinator.self) { _ in
            Coordinator(container: self.container)
        }

        container.register(TabBarController.self) { resolver in
            TabBarController(
                todayViewController: resolver.resolve(TodayViewController.self)!,
                forecastViewController: resolver.resolve(ForecastViewController.self)!,
                coordinator: resolver.resolve(Coordinator.self)!
            )
        }

        container.register(UINavigationController.self) { resolver in
            UINavigationController(rootViewController: resolver.resolve(TodayViewController.self)!)
        }
    }

    func getNavigationController() -> UINavigationController {
        return container.resolve(UINavigationController.self)!
    }
}

