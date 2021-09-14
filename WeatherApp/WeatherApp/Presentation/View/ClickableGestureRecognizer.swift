//
//  ClickableGestureRecognizer.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import UIKit

class ClickableGestureRecognizer: UITapGestureRecognizer {

    let onClick: () -> Void

    init(onClick: @escaping () -> Void, target: UIView,
         action: Selector, cancelsTouchesInView: Bool) {
        self.onClick = onClick
        super.init(target: target, action: action)
        self.cancelsTouchesInView = cancelsTouchesInView
    }
}
