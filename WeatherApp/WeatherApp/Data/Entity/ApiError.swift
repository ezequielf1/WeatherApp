//
//  ApiError.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiError: Decodable {
    let statusCode: Int?
    let error: String?
    let message: String?
    let errorCode: String?
}
