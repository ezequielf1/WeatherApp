//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ForecastResponse: Equatable {
    let city: String
    let forecast: [Forecast]
}
