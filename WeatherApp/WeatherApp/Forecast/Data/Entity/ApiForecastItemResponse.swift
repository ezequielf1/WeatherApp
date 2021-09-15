//
//  ApiForecastItemResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiForecastItemResponse: Decodable {
    let weather: [ApiForecastWeatherResponse]
    let main: ApiForecastMainResponse
    let dateText: String

    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case dateText = "dt_txt"
    }
}
