//
//  TodayModule.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

final class TodayModule {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    func inject() {
        container.register(TodayViewModel.self) { _ in
            .init()
        }

        container.register(TodayViewController.self) { resolver in
            .init(
                resolver.resolve(Coordinator.self)!,
                resolver.resolve(TodayViewModel.self)!
            )
        }
    }
}
