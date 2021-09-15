//
//  TodayHeaderView.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

import UIKit

final class TodayHeaderView: UICollectionReusableView {
    // MARK: - IBOutlets
    @IBOutlet private var weatherStateImageView: UIImageView!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func set(
        temperature: Double,
        weatherState: UiWeatherState,
        weatherDescription: String,
        cityName: String
    ) {
        temperatureLabel.text = "\(temperature)" + " | \(weatherDescription)"
        weatherStateImageView.image = weatherState.associatedImage
        locationLabel.text = cityName
    }
}

// MARK: - Private Methods
private extension TodayHeaderView {
    func setupUI() {
        locationLabel.textColor = Asset.Colors.black.color
        locationLabel.font = .systemFont(ofSize: TextSize.heading4, weight: .regular)
        locationLabel.textAlignment = .center

        temperatureLabel.font = .systemFont(ofSize: TextSize.heading3, weight: .regular)
        temperatureLabel.textColor = Asset.Colors.blue.color
        temperatureLabel.textAlignment = .center
    }
}
