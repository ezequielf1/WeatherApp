//
//  ForecastDataSource.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol ForecastDataSource {
    func getForecastData(
        latitude: Double,
        longitude: Double,
        onCompletion: @escaping (ApiResult<ForecastResponse>) -> Void
    )
}
