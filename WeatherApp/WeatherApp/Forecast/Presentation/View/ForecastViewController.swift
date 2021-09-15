//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit
import CoreLocation

final class ForecastViewController: BaseViewController<ForecastViewModel, Coordinator> {
    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!

    // MARK: - Private Properties
    private var forecastData: [UiForecast] = []
    private var locationManager = CLLocationManager()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    private lazy var locationNotAvailableView: LocationNotAvailableView = {
        LocationNotAvailableView().get(owner: self)
    }()
    private var currentLocation: CLLocation?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
}

// MARK: - Private Methods
private extension ForecastViewController {
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(forType: ForecastTableViewCell.self)
        tableView.refreshControl = refreshControl

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func bindViewModel() {
        subscribe(observable: viewModel.forecastDataObservable) { [weak self] data in
            guard let self = self else { return }
            self.dataRetrieved(data)
        }
    }

    func dataRetrieved(_ data: UiForecastResponse) {
        refreshControl.endRefreshing()
        forecastData = data.forecast
        title = data.city
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @objc func loadData() {
        guard let currentLocation = currentLocation else {
            refreshControl.endRefreshing()
            tableView.backgroundView = locationNotAvailableView
            return
        }
        viewModel.loadForecastData(
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude
        )
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastData[section].dayData.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        forecastData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(forType: ForecastTableViewCell.self, atIndexPath: indexPath) else {
            return .init()
        }
        cell.setup(data: forecastData[indexPath.section].dayData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        forecastData[section].day
    }
}

// MARK: - CLLocationManagerDelegate
extension ForecastViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let userLocation = locations.first else {
            return
        }
        currentLocation = userLocation
        loadData()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            tableView.backgroundView = locationNotAvailableView
        case .notDetermined:
            manager.requestAlwaysAuthorization()
            tableView.backgroundView = nil
        default:
            tableView.backgroundView = nil
        }
    }
}
