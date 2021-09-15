//
//  UiWeatherState.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

enum UiWeatherState: String, Equatable {
    case rain = "Rain"
    case clear = "Clear"
    case windy = "Windy"
    case clouds = "Clouds"
    case haze = "Haze"
    case unknown

    var associatedImage: UIImage {
        switch self {
        case .rain:
            return Asset.Assets.rainIcon.image
        case .clear:
            return Asset.Assets.sunnyIcon.image
        case .windy:
            return Asset.Assets.windyIcon.image
        case .clouds:
            return Asset.Assets.cloudyIcon.image
        case .haze:
            return Asset.Assets.hazeIcon.image
        case .unknown:
            return Asset.Assets.unknownIcon.image
        }
    }
}
