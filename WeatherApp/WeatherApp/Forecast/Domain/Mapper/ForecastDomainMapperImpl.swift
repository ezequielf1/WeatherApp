//
//  ForecastDomainMapperImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class ForecastDomainMapperImpl: ForecastDomainMapper {
    func domainToPresentation(_ data: ForecastResponse) -> UiForecastResponse {
        let forecast = data.forecast.sorted(by: { $0.dayNumber < $1.dayNumber }).map { forecast in
            UiForecast(
                day: forecast.day,
                dayData: forecast.dayData.map { dayData in
                    UiForecastDayData(
                        time: dayData.time,
                        temp: dayData.temp,
                        weatherState: UiWeatherState(rawValue: dayData.weatherState.rawValue) ?? .unknown,
                        weatherDescription: dayData.weatherDescription
                    )
                }
            )
        }
        return .init(city: data.city, forecast: forecast)
    }
}
