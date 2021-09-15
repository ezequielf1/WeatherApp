//
//  DataModule.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject

final class DataModule {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    func inject() {
        injectForecastModule()
        injectUserLocationModule()
        injectTodayWeatherModule()
    }

    private func injectForecastModule() {
        container.register(ForecastMapper.self) { _ in
            ForecastMapperImpl()
        }

        container.register(ForecastRemoteDataSource.self) { resolver in
            ForecastRemoteDataSourceImpl(manager: resolver.resolve(NetworkManager.self)!)
        }

        container.register(ForecastDataSource.self) { resolver in
            ForecastRepository(
                remote: resolver.resolve(ForecastRemoteDataSource.self)!,
                userLocationLocal: resolver.resolve(UserLocationLocalDataSource.self)!,
                mapper: resolver.resolve(ForecastMapper.self)!
            )
        }
    }

    private func injectUserLocationModule() {
        container.register(UserLocationLocalDataSource.self) { _ in
            UserLocationLocalDataSourceImpl()
        }
    }

    private func injectTodayWeatherModule() {
        container.register(TodayWeatherMapper.self) { _ in
            TodayWeatherMapperImpl()
        }

        container.register(TodayWeatherRemoteDataSource.self) { resolver in
            TodayWeatherRemoteDataSourceImpl(manager: resolver.resolve(NetworkManager.self)!)
        }

        container.register(TodayWeatherDataSource.self) { resolver in
            TodayWeatherRepository(
                remote: resolver.resolve(TodayWeatherRemoteDataSource.self)!,
                userLocationLocal: resolver.resolve(UserLocationLocalDataSource.self)!,
                mapper: resolver.resolve(TodayWeatherMapper.self)!
            )
        }
    }
}
