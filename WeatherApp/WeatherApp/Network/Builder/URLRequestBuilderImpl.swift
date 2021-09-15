//
//  URLRequestBuilderImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Alamofire

struct URLRequestBuilderImpl: URLRequestBuilder {
    func build(
        endpoint: String,
        httpMethod: HTTPMethod,
        queryItems: [String: Any?]
    ) -> URLRequest? {
        guard var urlComponents = URLComponents(string: ServerConstants.BASE_URL + endpoint) else {
            return nil
        }
        urlComponents.queryItems = buildQueryItem(from: queryItems)
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.headers = [
            .init(name: ServerConstants.rapidApiHostHeader, value: ServerConstants.rapidApiHostValue),
            .init(name: ServerConstants.rapidApiKeyHeader, value: ServerConstants.rapidApiKeyValue)
        ]
        return request
    }

    private func buildQueryItem(from queryItems: [String: Any?]) -> [URLQueryItem] {
        var result: [URLQueryItem] = []
        queryItems.forEach { key, value in
            var items: [URLQueryItem] = []
            if let value = value as? [Any?] {
                items = value.compactMap {
                    guard let value = $0 else { return nil }
                    return URLQueryItem(name: "\(key)[]", value: String(describing: value))
                }
            } else {
                if let value = value {
                    items = [URLQueryItem(name: key, value: String(describing: value))]
                }
            }
            result.append(contentsOf: items)
        }
        return result
    }
}

