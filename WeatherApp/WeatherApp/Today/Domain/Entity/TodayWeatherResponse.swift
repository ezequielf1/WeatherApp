//
//  TodayWeatherResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct TodayWeatherResponse: Equatable {
    let weatherState: WeatherState
    let cityName: String
    let humidity: Double
    let visibility: Double
    let pressure: Double
    let temperature: Double
    let weatherDescription: String
    let windSpeed: Double
}
