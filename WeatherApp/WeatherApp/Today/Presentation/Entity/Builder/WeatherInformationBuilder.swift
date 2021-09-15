//
//  WeatherInformationBuilder.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

protocol WeatherInformationBuilder {
    func build(_ data: UiTodayWeather) -> UiWeatherInformation
}
