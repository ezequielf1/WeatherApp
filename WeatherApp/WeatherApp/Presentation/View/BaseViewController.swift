//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class BaseViewController<V: BaseViewModel, C: Coordinator>: UIViewController, Alertable {

    let viewModel: V
    let coordinator: C

    let disposeBag = DisposeBag()

    // MARK: - Initializer
    init(_ coordinator: C,
         _ viewModel: V) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToIsLoadingObservable()
        subscribeToErrorObservable()
    }

    // MARK: - Subscribe to error
    func subscribeToErrorObservable() {
        subscribe(observable: viewModel.errorObservable) { [weak self] errorArgs in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(
                    title: errorArgs.title,
                    message: errorArgs.description ?? ""
                )
            }
        }
    }

    // MARK: - Public Methods
    func bind(observable: Observable<String>, label: UILabel) {
        observable.bind(to: label.rx.text).disposed(by: disposeBag)
    }

    func bind(observable: Observable<String>, label: UILabel, format: String) {
        observable.asObservable()
            .map { String(format: format, $0) }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

    func bind(observable: Observable<Bool>, action: @escaping (Bool) -> Void) {
        observable.bind { (result) in
            action(result)
        }.disposed(by: disposeBag)
    }

    func subscribe<T>(observable: Observable<T>, action: @escaping (T) -> Void) {
        observable.subscribe(onNext: { data in
            action(data)
        }).disposed(by: disposeBag)
    }

    func subscribeDistinct<T: Equatable>(observable: Observable<T>, action: @escaping (T) -> Void) {
        observable.distinctUntilChanged().subscribe(onNext: { data in
            action(data)
        }).disposed(by: disposeBag)
    }

    func listen<T>(observable: Observable<T>, action: @escaping (T?) -> Void, complete: @escaping () -> Void) {
        observable.subscribe(
            onNext: action, onError: nil, onCompleted: complete, onDisposed: nil
        ).disposed(by: disposeBag)
    }
}

extension BaseViewController: LoaderPresentable {
    private func subscribeToIsLoadingObservable() {
        subscribe(observable: viewModel.isLoadingObservable, action: { [unowned self] in
            $0 ?
                self.showLoader() :
                self.hideLoader()
        })
    }
}

