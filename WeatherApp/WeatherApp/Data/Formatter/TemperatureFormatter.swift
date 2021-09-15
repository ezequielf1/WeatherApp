//
//  TemperatureFormatter.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation

struct TemperatureFormatter {
    private static let kelvinConstant = 273.0

    static func kelvinToCelsius(_ temperature: Double) -> Double {
        (temperature - kelvinConstant).rounded()
    }
}
