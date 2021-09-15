//
//  ErrorType.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

enum ErrorType: Error {
    case connection
    case api(_ apiError: ApiError)
    case general(_ error: Error? = nil)
    case inward(_ error: InwardError)
}
