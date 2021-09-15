//
//  ApiForecastWeatherResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiForecastWeatherResponse: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
