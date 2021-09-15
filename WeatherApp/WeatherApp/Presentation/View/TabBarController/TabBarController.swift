//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import UIKit

final class TabBarController: UITabBarController {
    private let todayViewController: TodayViewController
    private let forecastViewController: ForecastViewController
    private let coordinator: Coordinator

    init(
        todayViewController: TodayViewController,
        forecastViewController: ForecastViewController,
        coordinator: Coordinator
    ) {
        self.todayViewController = todayViewController
        self.forecastViewController = forecastViewController
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setTabBarItems() {
        let todayNavController = UINavigationController(
            rootViewController: todayViewController
        )
        let forecastNavController = UINavigationController(
            rootViewController: forecastViewController
        )

        todayViewController.tabBarItem = .init(
            title: L10n.today,
            image: UIImage(systemName: "sun.max"),
            tag: TabBarItemType.today.rawValue
        )
        forecastViewController.tabBarItem = .init(
            title: L10n.forecast,
            image: UIImage(systemName: "cloud.sun.rain"),
            tag: TabBarItemType.forecast.rawValue
        )

        viewControllers = [
            todayNavController,
            forecastNavController
        ]

        setTabBarAppearance()
    }

    private func setTabBarAppearance() {
        tabBar.tintColor = Asset.Colors.blue.color
        let appearance = UITabBarItem.appearance()
        let unSelectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(
                ofSize: TextSize.caption2,
                weight: .medium
            ),
            .foregroundColor: Asset.Colors.black.color
        ]
        appearance.setTitleTextAttributes(unSelectedAttributes, for: .normal)

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Asset.Colors.blue.color
        ]
        appearance.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
