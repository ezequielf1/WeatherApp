//
//  UserLocationLocalDataSource.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

protocol UserLocationLocalDataSource {
    func getCurrentLocation(latitude: Double, longitude: Double, onCompletion: @escaping (UserLocation?, Error?) -> Void)
}
