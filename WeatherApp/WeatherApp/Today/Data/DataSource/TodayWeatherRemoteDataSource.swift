//
//  TodayWeatherRemoteDataSource.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol TodayWeatherRemoteDataSource {
    func getCurrentWeather(
        data: ApiTodayWeatherRequest,
        onCompletion: @escaping (ApiResult<ApiTodayWeatherResponse>) -> Void
    )
}
