//
//  ForecastDayData.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ForecastDayData: Equatable {
    let time: String
    let temp: Double
    let weatherState: WeatherState
    let weatherDescription: String
}
