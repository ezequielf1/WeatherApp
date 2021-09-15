//
//  UiForecastDayData.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct UiForecastDayData: Equatable {
    let time: String
    let temp: Double
    let weatherState: UiWeatherState
    let weatherDescription: String
}
