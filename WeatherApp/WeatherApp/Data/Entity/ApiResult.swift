//
//  ApiResult.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation

enum ApiResult<T> {
    case success(data: T)
    case error(error: ErrorType)
}
