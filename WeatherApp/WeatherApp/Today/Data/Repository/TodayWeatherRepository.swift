//
//  TodayWeatherRepository.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

final class TodayWeatherRepository: TodayWeatherDataSource {
    private let remote: TodayWeatherRemoteDataSource
    private let userLocationLocal: UserLocationLocalDataSource
    private let mapper: TodayWeatherMapper

    init(
        remote: TodayWeatherRemoteDataSource,
        userLocationLocal: UserLocationLocalDataSource,
        mapper: TodayWeatherMapper
    ) {
        self.remote = remote
        self.userLocationLocal = userLocationLocal
        self.mapper = mapper
    }

    func getCurrentWeather(
        latitude: Double,
        longitude: Double,
        onCompletion: @escaping (ApiResult<TodayWeatherResponse>) -> Void
    ) {
        userLocationLocal.getCurrentLocation(latitude: latitude, longitude: longitude) { [weak self] location, Error in
            guard let self = self, let locationDetails = location?.locationDetails else { return }
            let requestData = ApiTodayWeatherRequest(locationDetails: locationDetails)
            self.remote.getCurrentWeather(data: requestData) { [weak self] result in
                guard let self = self else { return }
                onCompletion(result.map(self.mapper.dataToDomain(_:)))
            }
        }
    }
}
