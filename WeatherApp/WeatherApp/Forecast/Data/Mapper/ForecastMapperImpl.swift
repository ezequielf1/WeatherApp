//
//  ForecastMapperImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation

final class ForecastMapperImpl: ForecastMapper {
    func dataToDomain(_ data: ApiForecastResponse) -> ForecastResponse {
        var forecast: [Forecast] = []
        let days = Dictionary(grouping: data.list, by: { DateMapper.format(dateString: $0.dateText)?.dayText })
        days.forEach { (key, value) in
            guard let key = key else { return }
            var dayNumber: Int?
            let dayData: [ForecastDayData] = value.map {
                let dateInformation = DateMapper.format(dateString: $0.dateText)
                dayNumber = dateInformation?.dayNumber
                return ForecastDayData(
                    time: dateInformation?.time ?? "",
                    temp: TemperatureFormatter.kelvinToCelsius($0.main.temp),
                    weatherState: WeatherState(rawValue: $0.weather.first?.main ?? "") ?? .unknown,
                    weatherDescription: $0.weather.first?.description ?? ""
                )
            }
            if let dayNumber = dayNumber {
                forecast.append(
                    .init(day: key, dayNumber: dayNumber, dayData: dayData)
                )
            }
        }
        return .init(city: data.city.name, forecast: forecast)
    }
}
