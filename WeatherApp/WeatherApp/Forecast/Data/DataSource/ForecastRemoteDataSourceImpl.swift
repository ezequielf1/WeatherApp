//
//  ForecastRemoteDataSourceImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class ForecastRemoteDataSourceImpl: ForecastRemoteDataSource {
    private let manager: NetworkManager

    init(manager: NetworkManager) {
        self.manager = manager
    }

    func getForecastData(data: ApiForecastRequest, onCompletion: @escaping (ApiResult<ApiForecastResponse>) -> Void) {
        manager.requestWithQuery(
            endpoint: ServerConstants.fiveDayThreeHours,
            method: .get,
            queryItems: ["q": data.locationDetails],
            onCompletion: onCompletion
        )
    }
}
