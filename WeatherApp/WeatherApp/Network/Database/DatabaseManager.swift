//
//  DatabaseManager.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

protocol DatabaseManager {
    func saveUserLocation(data: String)
    func getUserLocation(onCompletion: @escaping (ApiResult<String?>) -> Void)
}
