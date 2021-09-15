//
//  GetForecastDataUseCase.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct UiGetForecastDataRequest: Equatable {
    let latitude: Double
    let longitude: Double
}

final class GetForecastDataUseCase: ClosureUseCase {
    typealias RequestType = UiGetForecastDataRequest
    typealias ResultType = UiForecastResponse
    typealias Alias = AnyClosureUseCase<RequestType, ResultType>

    // MARK: - Private Properties
    private let dataSource: ForecastDataSource
    private let mapper: ForecastDomainMapper

    init(dataSource: ForecastDataSource, mapper: ForecastDomainMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }

    func execute(_ parameters: RequestType, _ onCompletion: @escaping (ApiResult<ResultType>) -> Void) {
        dataSource.getForecastData(latitude: parameters.latitude, longitude: parameters.longitude) { [weak self] result in
            guard let self = self else { return }
            onCompletion(result.map(self.mapper.domainToPresentation(_:)))
        }
    }
}
