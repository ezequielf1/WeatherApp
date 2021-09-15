//
//  ForecastRemoteDataSource.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol ForecastRemoteDataSource {
    func getForecastData(data: ApiForecastRequest, onCompletion: @escaping (ApiResult<ApiForecastResponse>) -> Void)
}
