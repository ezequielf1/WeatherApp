//
//  ApiError.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct ApiError: Decodable {
    let cod: String?
    let message: String?
}
