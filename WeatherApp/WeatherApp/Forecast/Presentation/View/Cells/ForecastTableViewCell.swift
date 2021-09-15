//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var weatherStateImageView: UIImageView!
    @IBOutlet private var weatherStateLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setup(data: UiForecastDayData) {
        timeLabel.text = data.time
        weatherStateLabel.text = data.weatherDescription
        temperatureLabel.text = "\(data.temp)º"
        weatherStateImageView.image = data.weatherState.associatedImage
    }

    // MARK: - Private Methods
    private func setupUI() {
        temperatureLabel.textColor = Asset.Colors.blue.color
        temperatureLabel.font = .systemFont(ofSize: TextSize.heading1, weight: .medium)

        weatherStateLabel.textColor = Asset.Colors.black.color
        weatherStateLabel.font = .systemFont(ofSize: TextSize.footnote, weight: .regular)

        timeLabel.textColor = Asset.Colors.black.color
        timeLabel.font = .systemFont(ofSize: TextSize.heading5, weight: .regular)
    }
}
