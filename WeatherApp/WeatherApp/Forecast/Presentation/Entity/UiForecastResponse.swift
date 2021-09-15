//
//  UiForecastResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct UiForecastResponse: Equatable {
    let city: String
    let forecast: [UiForecast]
}
