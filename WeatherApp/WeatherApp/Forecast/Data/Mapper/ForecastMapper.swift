//
//  ForecastMapper.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol ForecastMapper {
    func dataToDomain(_ data: ApiForecastResponse) -> ForecastResponse
}
