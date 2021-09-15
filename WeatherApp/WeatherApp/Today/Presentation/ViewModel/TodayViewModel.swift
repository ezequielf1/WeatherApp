//
//  TodayViewModel.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import RxSwift

final class TodayViewModel: BaseViewModel {
    // MARK: - Private Properties
    private let getCurrentWeatherUseCase: GetCurrentWeatherUseCase.Alias
    private let weatherDataSubject = PublishSubject<UiWeatherInformation>()
    private let weatherInformationBuilder: WeatherInformationBuilder

    // MARK: - Public Properties
    var weatherDataObservable: Observable<UiWeatherInformation> {
        weatherDataSubject.asObservable()
    }

    // MARK: - Initializer
    init(
        getCurrentWeatherUseCase: GetCurrentWeatherUseCase.Alias,
        weatherInformationBuilder: WeatherInformationBuilder
    ) {
        self.getCurrentWeatherUseCase = getCurrentWeatherUseCase
        self.weatherInformationBuilder = weatherInformationBuilder
    }

    // MARK: - Public Methods
    func loadData(latitude: Double, longitude: Double) {
        let requestData = UiGetCurrentWeatherRequest(latitude: latitude, longitude: longitude)
        isLoadingSubject.onNext(true)
        getCurrentWeatherUseCase.execute(requestData) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingSubject.onNext(false)
            switch result {
            case .success(let data):
                self.weatherDataSubject.onNext(self.weatherInformationBuilder.build(data))
            case .error(let error):
                self.onError(error)
            }
        }
    }
}
