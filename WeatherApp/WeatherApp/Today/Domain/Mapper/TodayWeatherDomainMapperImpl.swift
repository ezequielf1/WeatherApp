//
//  TodayWeatherDomainMapperImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class TodayWeatherDomainMapperImpl: TodayWeatherDomainMapper {
    func domainToPresentation(_ data: TodayWeatherResponse) -> UiTodayWeather {
        .init(
            weatherState: .init(rawValue: data.weatherState.rawValue) ?? .unknown,
            cityName: data.cityName,
            humidity: data.humidity,
            visibility: data.visibility,
            pressure: data.pressure,
            temperature: data.temperature,
            weatherDescription: data.weatherDescription,
            windSpeed: data.windSpeed
        )
    }
}
