//
//  ClosureUseCase.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol ClosureUseCase: Reusable {

    associatedtype RequestType
    associatedtype ResultType

    func execute(
        _ parameters: RequestType,
        _ onCompletion: @escaping (ApiResult<ResultType>) -> Void
    )
}
