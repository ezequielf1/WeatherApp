//
//  DomainModule.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

final class DomainModule {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    func inject() {
        injectForecastModule()
    }

    private func injectForecastModule() {
        container.register(ForecastDomainMapper.self) { _ in
            ForecastDomainMapperImpl()
        }

        container.register(TodayWeatherDomainMapper.self) { _ in
            TodayWeatherDomainMapperImpl()
        }
    }
}

