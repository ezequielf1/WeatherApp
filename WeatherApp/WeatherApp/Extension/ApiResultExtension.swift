//
//  AApiResultExtension.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

extension ApiResult {
    func map<R>(_ transform: (T) -> R) -> ApiResult<R> {
        switch self {
        case .success(let data):
            return ApiResult<R>.success(data: transform(data))
        case .error(let error):
            return ApiResult<R>.error(error: error)
        }
    }
}
