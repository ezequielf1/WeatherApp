//
//  WeatherInformationCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

import UIKit

final class WeatherInformationCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var valueLabel: UILabel!

    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Public Methods
    func set(item: UiWeatherItemInformation) {
        valueLabel.text = String(describing: item.value) + " \(item.type.measurementUnit)"
        iconImageView.image = item.type.icon
    }

    // MARK: - Private Methods
    private func setupUI() {
        valueLabel.textColor = Asset.Colors.black.color
        valueLabel.font = .systemFont(ofSize: TextSize.footnote, weight: .regular)
        valueLabel.textAlignment = .center
    }
}
