//
//  UserLocationLocalDataSourceImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import CoreLocation

final class UserLocationLocalDataSourceImpl: UserLocationLocalDataSource {
    private let geocoder = CLGeocoder()

    func getCurrentLocation(latitude: Double, longitude: Double, onCompletion: @escaping (UserLocation?, Error?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if error != nil {
                return onCompletion(nil, error)
            }
            if let placemark = placemarks?.first {
                guard let locality = placemark.locality, let country = placemark.country else {
                    return onCompletion(nil, ErrorType.general())
                }
                let locationDetails = locality + "," + country
                return onCompletion(.init(latitude: latitude, longitude: longitude, locationDetails: locationDetails), nil)
            }
        }
    }
}

struct UserLocation {
    let latitude: Double
    let longitude: Double
    let locationDetails: String
}
