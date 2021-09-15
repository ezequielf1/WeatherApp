//
//  UICollectionViewExtension.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

import UIKit

extension UICollectionView {
    func registerNib<T>(forType type: T.Type) where T: UICollectionViewCell {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T>(forType type: T.Type,
                                atIndexPath indexPath: IndexPath) -> T? where T: UICollectionViewCell {
        let identifier = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
    }
}
