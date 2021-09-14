//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Alamofire

protocol NetworkManager {
    func requestWithQuery<R: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        queryItems: [String: Any],
        onCompletion: @escaping (ApiResult<R>) -> Void
    )
}
