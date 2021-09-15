//
//  Forecast.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation

struct Forecast: Equatable {
    let day: String
    let dayNumber: Int
    let dayData: [ForecastDayData]
}
