//
//  TodayWeatherRemoteDataSourceImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class TodayWeatherRemoteDataSourceImpl: TodayWeatherRemoteDataSource {
    private let manager: NetworkManager

    init(manager: NetworkManager) {
        self.manager = manager
    }

    func getCurrentWeather(
        data: ApiTodayWeatherRequest,
        onCompletion: @escaping (ApiResult<ApiTodayWeatherResponse>) -> Void
    ) {
        manager.requestWithQuery(
            endpoint: ServerConstants.currentWeather,
            method: .get,
            queryItems: ["q": data.locationDetails],
            onCompletion: onCompletion
        )
    }
}
