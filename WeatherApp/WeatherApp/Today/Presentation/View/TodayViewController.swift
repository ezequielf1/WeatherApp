//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit
import CoreLocation

final class TodayViewController: BaseViewController<TodayViewModel, Coordinator> {
    // MARK: - IBOutlets
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var shareButton: UIButton!

    // MARK: - Private Properties
    private var locationManager = CLLocationManager()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    private var currentLocation: CLLocation?
    private let collectionViewHeaderReuseIdentifier = "TodayHeaderView"
    private var items: [UiWeatherItemInformation] = []
    private var collectionHeaderView: UICollectionReusableView?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        bindUI()
    }
}

// MARK: - Private Methods
private extension TodayViewController {
    func setupUI() {
        title = L10n.today

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }

        collectionView.register(
            .init(nibName: collectionViewHeaderReuseIdentifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: collectionViewHeaderReuseIdentifier
        )
        collectionView.registerNib(forType: WeatherInformationCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self

        shareButton.setTitle(L10n.share, for: .normal)
        shareButton.setTitleColor(Asset.Colors.orange.color, for: .normal)
        shareButton.backgroundColor = .clear
    }

    func bindViewModel() {
        subscribe(observable: viewModel.weatherDataObservable) { [weak self] data in
            guard let self = self else { return }
            self.dataRetrieved(data)
        }
    }

    func bindUI() {
        shareButton.onClick { [weak self] in
            guard let self = self else { return }
            self.share(sender: self.view)
        }
    }

    func dataRetrieved(_ data: UiWeatherInformation) {
        items = data.items
        if let header = collectionHeaderView as? TodayHeaderView {
            header.set(
                temperature: data.temperature,
                weatherState: data.state,
                weatherDescription: data.weatherDescription,
                cityName: data.cityName
            )
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @objc func loadData() {
        guard let currentLocation = currentLocation else {
            return showAlert(message: L10n.userLocationNotAvailable)
        }
        viewModel.loadData(
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude
        )
    }

    @objc func share(sender: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let textToShare = L10n.checkOutTheWeather

        // In the actual app, the button share will send a link to the application so the other person can download it
        if let myWebsite = URL(string: "http://itunes.apple.com/app/idXXXXXXXXX") {
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            activityVC.excludedActivityTypes = [
                UIActivity.ActivityType.airDrop,
                UIActivity.ActivityType.addToReadingList
            ]

            activityVC.popoverPresentationController?.sourceView = sender
            present(activityVC, animated: true, completion: nil)
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension TodayViewController: CLLocationManagerDelegate {
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
            showAlert(message: L10n.appOnlyWorksWithLocationAuth)
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        default:
            break
        }
    }
}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            forType: WeatherInformationCollectionViewCell.self,
            atIndexPath: indexPath
        ) else {
            return .init()
        }
        cell.set(item: items[indexPath.row])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: collectionViewHeaderReuseIdentifier,
                for: indexPath
            )
            self.collectionHeaderView = header
            return header
        default:
            break
        }
        return .init()
    }
}
