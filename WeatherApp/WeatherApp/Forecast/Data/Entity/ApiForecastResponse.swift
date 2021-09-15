//
//  ApiForecastResponse.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiForecastResponse: Decodable {
    let list: [ApiForecastItemResponse]
    let city: ApiCityResponse
}
