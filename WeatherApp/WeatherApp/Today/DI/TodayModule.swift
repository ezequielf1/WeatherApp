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
        container.register(GetCurrentWeatherUseCase.Alias.self, name: GetCurrentWeatherUseCase.identifier) { resolver in
            GetCurrentWeatherUseCase.Alias(
                GetCurrentWeatherUseCase(dataSource: resolver.resolve(TodayWeatherDataSource.self)!,
                                         mapper: resolver.resolve(TodayWeatherDomainMapper.self)!)
            )
        }

        container.register(WeatherInformationBuilder.self) { _ in
            WeatherInformationBuilderImpl()
        }

        container.register(TodayViewModel.self) { resolver in
            .init(getCurrentWeatherUseCase: resolver.resolve(GetCurrentWeatherUseCase.Alias.self,
                                                             name: GetCurrentWeatherUseCase.identifier)!,
                  weatherInformationBuilder: resolver.resolve(WeatherInformationBuilder.self)!)
        }

        container.register(TodayViewController.self) { resolver in
            .init(
                resolver.resolve(Coordinator.self)!,
                resolver.resolve(TodayViewModel.self)!
            )
        }
    }
}
