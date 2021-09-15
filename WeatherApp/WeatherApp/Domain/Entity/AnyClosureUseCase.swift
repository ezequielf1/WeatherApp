//
//  AnyClosureUseCase.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation

class AnyClosureUseCase<RequestType, ResultType>: ClosureUseCase {

    private let call: (RequestType, @escaping (ApiResult<ResultType>) -> Void) -> Void

    init<T: ClosureUseCase>(_ useCase: T) where
        T.RequestType == RequestType,
        T.ResultType == ResultType {
        call = useCase.execute
    }

    func execute(
        _ parameters: RequestType,
        _ onCompletion: @escaping (ApiResult<ResultType>) -> Void
    ) {
        call(parameters, onCompletion)
    }
}
