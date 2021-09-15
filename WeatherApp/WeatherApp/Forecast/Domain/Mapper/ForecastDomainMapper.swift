//
//  ForecastDomainMapper.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol ForecastDomainMapper {
    func domainToPresentation(_ data: ForecastResponse) -> UiForecastResponse
}
