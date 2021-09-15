//
//  ServerConstants.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ServerConstants {
    static let BASE_URL = "https://community-open-weather-map.p.rapidapi.com"

    // MARK: - Headers
    static let rapidApiHostHeader = "x-rapidapi-host"
    static let rapidApiKeyHeader = "x-rapidapi-key"
    static let rapidApiHostValue = "community-open-weather-map.p.rapidapi.com"
    static let rapidApiKeyValue = "36d37c0db8msh805fe1a6cc4578fp1636fejsn36d51e7106fe"

    // MARK: - Endpoints
    static let fiveDayThreeHours = "/forecast"
    static let currentWeather = "/weather"
}
