//
//  ApiForecastMainResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiForecastMainResponse: Decodable {
    let temp: Double
    let pressure: Double
    let humidity: Double
}
