//
//  GetCurrentWeatherUseCase.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

struct UiGetCurrentWeatherRequest: Equatable {
    let latitude: Double
    let longitude: Double
}

final class GetCurrentWeatherUseCase: ClosureUseCase {
    typealias RequestType = UiGetCurrentWeatherRequest
    typealias ResultType = UiTodayWeather
    typealias Alias = AnyClosureUseCase<RequestType, ResultType>

    // MARK: - Private Properties
    private let dataSource: TodayWeatherDataSource
    private let mapper: TodayWeatherDomainMapper

    init(dataSource: TodayWeatherDataSource, mapper: TodayWeatherDomainMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }

    func execute(_ parameters: RequestType, _ onCompletion: @escaping (ApiResult<ResultType>) -> Void) {
        dataSource.getCurrentWeather(latitude: parameters.latitude, longitude: parameters.longitude) { [weak self] result in
            guard let self = self else { return }
            onCompletion(result.map(self.mapper.domainToPresentation(_:)))
        }
    }
}
