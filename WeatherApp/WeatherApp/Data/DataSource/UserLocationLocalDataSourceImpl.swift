//
//  UserLocationLocalDataSourceImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import CoreLocation

final class UserLocationLocalDataSourceImpl: UserLocationLocalDataSource {
    private let geocoder = CLGeocoder()
    private let databaseManager: DatabaseManager

    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }

    func getCurrentLocation(latitude: Double, longitude: Double, onCompletion: @escaping (UserLocation?, Error?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            return self.getLocationFromDatabase(latitude: latitude, lonngitude: longitude, onCompletion: onCompletion)
            if error != nil {
                return self.getLocationFromDatabase(latitude: latitude, lonngitude: longitude, onCompletion: onCompletion)
            }
            if let placemark = placemarks?.first {
                guard let locality = placemark.locality, let country = placemark.country else {
                    return self.getLocationFromDatabase(latitude: latitude, lonngitude: longitude, onCompletion: onCompletion)
                }
                let locationDetails = locality + "," + country
                self.databaseManager.saveUserLocation(data: locationDetails)
                return onCompletion(.init(latitude: latitude, longitude: longitude, locationDetails: locationDetails), nil)
            } else {
                self.getLocationFromDatabase(latitude: latitude, lonngitude: longitude, onCompletion: onCompletion)
            }
        }
    }

    private func getLocationFromDatabase(
        latitude: Double,
        lonngitude: Double,
        onCompletion: @escaping (UserLocation?, Error?) -> Void
    ) {
        databaseManager.getUserLocation { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    return onCompletion(nil, ErrorType.general())
                }
                onCompletion(.init(latitude: latitude, longitude: lonngitude, locationDetails: data), nil)
            case .error(let error):
                onCompletion(nil, error)
            }
        }
    }
}

struct UserLocation {
    let latitude: Double
    let longitude: Double
    let locationDetails: String
}
