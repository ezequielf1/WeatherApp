//
//  UiTodayWeather.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct UiTodayWeather: Equatable {
    let weatherState: UiWeatherState
    let cityName: String
    let humidity: Double?
    let visibility: Double?
    let pressure: Double?
    let temperature: Double
    let weatherDescription: String
    let windSpeed: Double?
}
