//
//  DatabaseManagerImpl.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 15-09-21.
//

import Firebase

final class DatabaseManagerImpl: DatabaseManager {
    private var ref: DatabaseReference
    // In the actual app, the username change between users
    private let mockUserId = "mockUserId"
    private let locationDetailsKey = "locationDetails"

    init(ref: DatabaseReference) {
        self.ref = ref
    }

    func saveUserLocation(data: String) {
        ref.child("users").child(mockUserId).setValue([locationDetailsKey: data])
    }

    func getUserLocation(onCompletion: @escaping (ApiResult<String?>) -> Void) {
        ref.child("users/\(mockUserId)/\(locationDetailsKey)").getData { error, snapshot in
            if let error = error {
                onCompletion(.error(error: .general(error)))
            } else if snapshot.exists() {
                onCompletion(.success(data: snapshot.value as? String))
            } else {
                onCompletion(.error(error: .inward(.emptyResponse)))
            }
        }
    }
}
