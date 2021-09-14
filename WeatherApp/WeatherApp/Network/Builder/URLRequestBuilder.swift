//
//  URLRequestBuilder.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Alamofire

protocol URLRequestBuilder {
    func build(
        endpoint: String,
        httpMethod: HTTPMethod,
        queryItems: [String: Any?]
    ) -> URLRequest?
}
