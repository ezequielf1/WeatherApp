//
//  InwardError.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

enum InwardError {
    case malformedUrl
    case decoding
    case emptyResponse
    case timeout

    var message: String {
        switch self {
        case .malformedUrl:
            return L10n.malformedUrl
        case .decoding:
            return L10n.decodingError
        case .emptyResponse:
            return L10n.emptyResponseError
        case .timeout:
            return L10n.timeoutError
        }
    }
}
