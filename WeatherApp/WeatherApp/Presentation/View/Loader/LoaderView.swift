//
//  LoaderView.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

final class LoaderView: UIView, PresentableLoader {
    @IBOutlet private var view: UIView!
    @IBOutlet private var hudView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    private let showHudTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    private let hideHudTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    private let animationDuration = 0.3
    private let shadowOffset = CGSize(width: 1, height: 1)
    private let shadowOpacity: Float = 0.7
    private let dimColor: UIColor = .white //Asset.Colors.textPrimary.color
    private let minDimAlpha: CGFloat = 0.0
    private let maxDimAlpha: CGFloat = 0.5
    private let minHudAlpha: CGFloat = 0.0
    private let maxHudAlpha: CGFloat = 1.0
    private let hideAnimationDelay: TimeInterval = 0.0

    private lazy var dimColorWithMinAlpha: UIColor = {
        dimColor.withAlphaComponent(self.minDimAlpha)
    }()

    private lazy var dimColorWithMaxAlpha: UIColor = {
        dimColor.withAlphaComponent(self.maxDimAlpha)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }

    func show() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let allWindows = UIApplication.shared.windows.reversed()
            for window in allWindows where window.windowLevel == .normal {
                window.addSubview(self.view)
                self.view.frame = window.bounds
                break
            }

            self.view.backgroundColor = self.dimColorWithMinAlpha
            self.hudView.isHidden = false
            self.hudView.alpha = self.minHudAlpha
            self.hudView.transform = self.showHudTransform

            UIView.animate(withDuration: self.animationDuration,
                           animations: { [weak self] in
                            guard let self = self else { return }
                            self.view.backgroundColor = self.dimColorWithMaxAlpha
                            self.hudView.alpha = self.maxHudAlpha
                            self.hudView.transform = CGAffineTransform.identity
                           })
        }
    }

    func hide() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view.backgroundColor = self.dimColorWithMaxAlpha
            UIView.animate(withDuration: self.animationDuration,
                           delay: self.hideAnimationDelay,
                           options: .curveLinear,
                           animations: { [weak self] in
                            guard let self = self else { return }
                            self.view.backgroundColor = self.dimColorWithMinAlpha
                            self.view.alpha = self.minHudAlpha
                            self.view.transform = self.hideHudTransform
                           }, completion: { [weak self] _ in
                            self?.view.removeFromSuperview()
                           })
        }
    }
}

extension LoaderView {
    func xibSetup() {
        view = LoaderView.loadNib(owner: self)
        addSubview(view)
        view.frame = bounds
        appearance()
    }

    private func appearance() {
        // hudView.backgroundColor = Asset.Colors.background.color
        hudView.layer.cornerRadius = ViewConstants.CornerRadius.medium
        hudView.layer.shadowColor = dimColor.cgColor
        hudView.layer.shadowRadius = ViewConstants.CornerRadius.medium
        hudView.layer.shadowOpacity = shadowOpacity
        hudView.layer.shadowOffset = shadowOffset
    }
}

