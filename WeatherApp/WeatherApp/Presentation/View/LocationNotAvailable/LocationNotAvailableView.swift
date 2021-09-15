//
//  LocationNotAvailableView.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

final class LocationNotAvailableView: UIView, ManualRender {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        titleLabel.textColor = Asset.Colors.black.color
        titleLabel.text = L10n.userLocationNotAvailable
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: TextSize.heading3, weight: .regular)

        descriptionLabel.text = L10n.appOnlyWorksWithLocationAuth
        descriptionLabel.textColor = Asset.Colors.black.color
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: TextSize.heading5, weight: .regular)

        imageView.image = Asset.Assets.locationNotAvailable.image
    }
}
