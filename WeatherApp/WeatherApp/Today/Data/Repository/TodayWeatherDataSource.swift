//
//  TodayWeatherDataSource.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol TodayWeatherDataSource {
    func getCurrentWeather(
        latitude: Double,
        longitude: Double,
        onCompletion: @escaping (ApiResult<TodayWeatherResponse>) -> Void
    )
}
