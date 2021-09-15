//
//  TodayWeatherMapper.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol TodayWeatherMapper {
    func dataToDomain(_ data: ApiTodayWeatherResponse) -> TodayWeatherResponse
}
