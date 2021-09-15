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
        container.register(GetForecastDataUseCase.Alias.self, name: GetForecastDataUseCase.identifier) { resolver in
            GetForecastDataUseCase.Alias(
                GetForecastDataUseCase(dataSource: resolver.resolve(ForecastDataSource.self)!,
                                       mapper: resolver.resolve(ForecastDomainMapper.self)!)
            )
        }

        container.register(ForecastViewModel.self) { resolver in
            .init(
                getForecastDataUseCase: resolver.resolve(GetForecastDataUseCase.Alias.self,
                                                         name: GetForecastDataUseCase.identifier)!
            )
        }

        container.register(ForecastViewController.self) { resolver in
            .init(
                resolver.resolve(Coordinator.self)!,
                resolver.resolve(ForecastViewModel.self)!
            )
        }
    }
}
