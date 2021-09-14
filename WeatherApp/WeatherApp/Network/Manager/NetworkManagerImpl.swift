//
//  NetworkManagerImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Alamofire

final class NetworkManagerImpl: NetworkManager {
    private static let successStatusCodes = 200..<300

    private let alamofire: Session
    private let decoder = JSONDecoder()
    private let urlRequestBuilder: URLRequestBuilder

    init(alamofire: Session, urlRequestBuilder: URLRequestBuilder = URLRequestBuilderImpl()) {
        self.alamofire = alamofire
        self.urlRequestBuilder = urlRequestBuilder
    }

    func requestWithQuery<R: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        queryItems: [String: Any],
        onCompletion: @escaping (ApiResult<R>) -> Void
    ) {
        guard let request = urlRequestBuilder.build(
                endpoint: endpoint,
                httpMethod: method,
                queryItems: queryItems) else {
            return onCompletion(.error(error: .inward(.malformedUrl)))
        }
        alamofire.request(
            request
        )
        .validate(statusCode: Self.successStatusCodes)
        .responseJSON() { [weak self] response in
            guard let self = self else { return }
            self.onResponse(response, onCompletion: onCompletion)
        }
    }

    private func onResponse<R: Decodable>(
        _ response: AFDataResponse<Any>,
        onCompletion: @escaping (ApiResult<R>) -> Void
    ) {
        switch response.result {
        case .success:
            self.onSuccess(response.data, onCompletion)
        case .failure:
            self.onError(response, onCompletion)
        }
    }

    private func onSuccess<R: Decodable>(
        _ data: Data?,
        _ onCompletion: @escaping (ApiResult<R>) -> Void
    ) {
        guard let data = data else {
            return onCompletion(.error(error: .inward(.emptyResponse)))
        }
        do {
            let dataAsObject = try decoder.decode(R.self, from: data)
            onCompletion(ApiResult.success(data: dataAsObject))
        } catch {
            #if !RELEASE
            print("error \(error)")
            #endif
            onCompletion(ApiResult.error(error: .inward(.decoding)))
        }
    }

    private func onError<R>(
        _ response: AFDataResponse<Any>,
        _ onCompletion: @escaping (ApiResult<R>) -> Void
    ) {
        #if !RELEASE
        debugPrint(response.error ?? "An error occurred making a request")
        #endif
        onCompletion(ApiResult.error(error: .general()))
//        if let error = response.error {
//            guard error.responseCode != NSURLErrorTimedOut else {
//                return onCompletion(.error(error: .inward(.timeout)))
//            }
//            guard !isNotFound(error.responseCode) || response.data != nil else {
//                return onCompletion(.error(error: .notFound))
//            }
//            if isAuthorized(error.responseCode) {
//                decodeErrorBody(response.data, onCompletion)
//            } else {
//                onCompletion(ApiResult.unauthorized(error: error))
//            }
//        } else {
//            onCompletion(ApiResult.error(error: .general()))
//        }
    }
}
