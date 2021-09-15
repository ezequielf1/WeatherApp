//
//  ApiTodayWeatherResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiTodayWeatherResponse: Decodable {
    let weather: [ApiForecastWeatherResponse]
    let main: ApiForecastMainResponse
    let visibility: Double
    let wind: ApiWeatherWindResponse
    let name: String
}

struct ApiWeatherWindResponse: Decodable {
    let speed: Double
    let deg: Double
    let gust: Double
}
