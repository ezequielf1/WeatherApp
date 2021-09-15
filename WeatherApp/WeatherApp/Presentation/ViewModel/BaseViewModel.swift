//
//  BaseViewModel.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import RxSwift

class BaseViewModel {
    final let isLoadingSubject = PublishSubject<Bool>()
    final let errorSubject = PublishSubject<ErrorArgs>()

    final var isLoadingObservable: Observable<Bool> {
        isLoadingSubject.asObservable()
    }
    final var errorObservable: Observable<ErrorArgs> {
        errorSubject.asObservable()
    }

    func onError(_ errorType: ErrorType) {
        errorSubject.onNext(getArgs(for: errorType))
    }

    private func getArgs(for errorType: ErrorType) -> ErrorArgs {
        switch errorType {
        case .connection:
            return .init(
                title: L10n.error,
                description: L10n.connectionError
            )
        case .api(let apiError):
            return .init(
                title: "\(L10n.error) \(getStatusCode(from: apiError))",
                description: apiError.message
            )
        case .general(let error):
            return .init(
                title: L10n.error,
                description: error?.localizedDescription
            )
        case .inward(let error):
            #if DEBUG
            print("An error has ocurred: \(error.message)")
            #endif
            return .init(
                title: L10n.error,
                description: error.message
            )
        }
    }

    private func getStatusCode(from error: ApiError) -> String {
        error.cod != nil ? "\(error.cod!)" : ""
    }
}

