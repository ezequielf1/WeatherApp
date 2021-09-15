//
//  UiWeatherItemType.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

import UIKit

enum UiWeatherItemType {
    case windSpeed
    case humidity
    case pressure
    case visibility

    var icon: UIImage {
        switch self {
        case .windSpeed:
            return Asset.Assets.windIcon.image
        case .humidity:
            return Asset.Assets.humidityIcon.image
        case .pressure:
            return Asset.Assets.pressureIcon.image
        case .visibility:
            return Asset.Assets.visibilityIcon.image
        }
    }

    var measurementUnit: String {
        switch self {
        case .windSpeed:
            return "km/h"
        case .humidity:
            return "%"
        case .pressure:
            return "hPa"
        case .visibility:
            return "mts"
        }
    }
}
