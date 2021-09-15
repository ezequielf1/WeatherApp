//
//  ForecastRepository.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class ForecastRepository: ForecastDataSource {
    private let remote: ForecastRemoteDataSource
    private let userLocationLocal: UserLocationLocalDataSource
    private let mapper: ForecastMapper

    init(
        remote: ForecastRemoteDataSource,
        userLocationLocal: UserLocationLocalDataSource,
        mapper: ForecastMapper
    ) {
        self.remote = remote
        self.userLocationLocal = userLocationLocal
        self.mapper = mapper
    }

    func getForecastData(
        latitude: Double,
        longitude: Double,
        onCompletion: @escaping (ApiResult<ForecastResponse>) -> Void
    ) {
        userLocationLocal.getCurrentLocation(latitude: latitude, longitude: longitude) { [weak self] userLocation, error in
            guard let self = self, let locationDetails = userLocation?.locationDetails else { return }
            let requestData = ApiForecastRequest(locationDetails: locationDetails)
            self.remote.getForecastData(data: requestData) { [weak self] result in
                guard let self = self else { return }
                onCompletion(result.map(self.mapper.dataToDomain(_:)))
            }
        }
    }
}
