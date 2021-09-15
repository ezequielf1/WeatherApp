//
//  TodayWeatherMapperImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class TodayWeatherMapperImpl: TodayWeatherMapper {
    func dataToDomain(_ data: ApiTodayWeatherResponse) -> TodayWeatherResponse {
        .init(
            weatherState: WeatherState(rawValue: data.weather.first?.main ?? "") ?? .unknown,
            cityName: data.name,
            humidity: data.main.humidity,
            visibility: data.visibility,
            pressure: data.main.pressure,
            temperature: data.main.temp,
            weatherDescription: data.weather.first?.description ?? "",
            windSpeed: data.wind.speed
        )
    }
}
