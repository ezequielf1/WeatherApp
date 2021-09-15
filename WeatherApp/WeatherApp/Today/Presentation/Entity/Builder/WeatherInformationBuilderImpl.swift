//
//  WeatherInformationBuilderImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

final class WeatherInformationBuilderImpl: WeatherInformationBuilder {
    func build(_ data: UiTodayWeather) -> UiWeatherInformation {
        var items: [UiWeatherItemInformation] = []
        if let windSpeed = data.windSpeed {
            items.append(.init(value: windSpeed, type: .windSpeed))
        }
        if let humidity = data.humidity {
            items.append(.init(value: humidity, type: .humidity))
        }
        if let pressure = data.pressure {
            items.append(.init(value: pressure, type: .pressure))
        }
        if let visibility = data.visibility {
            items.append(.init(value: visibility, type: .visibility))
        }
        return .init(
            temperature: data.temperature,
            weatherDescription: data.weatherDescription,
            state: data.weatherState,
            cityName: data.cityName,
            items: items
        )
    }
}
