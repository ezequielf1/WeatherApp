//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import RxSwift

final class ForecastViewModel: BaseViewModel {
    // MARK: - Private Properties
    private let getForecastDataUseCase: GetForecastDataUseCase.Alias
    private let forecastDataSubject = PublishSubject<UiForecastResponse>()

    // MARK: - Public Properties
    var forecastDataObservable: Observable<UiForecastResponse> {
        forecastDataSubject.asObservable()
    }

    // MARK: - Initializer
    init(getForecastDataUseCase: GetForecastDataUseCase.Alias) {
        self.getForecastDataUseCase = getForecastDataUseCase
    }

    // MARK: - Public Methods
    func loadForecastData(latitude: Double, longitude: Double) {
        let requestData = UiGetForecastDataRequest(latitude: latitude, longitude: longitude)
        isLoadingSubject.onNext(true)
        getForecastDataUseCase.execute(requestData) { [weak self] result in
            guard let self = self else { return }
            self.isLoadingSubject.onNext(false)
            switch result {
            case .success(let data):
                self.forecastDataSubject.onNext(data)
            case .error(let error):
                self.onError(error)
            }
        }
    }
}
