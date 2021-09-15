//
//  NetworkModule.swift
//  WeatherApp
//
//  Created by Ezequiel Fritz on 14-09-21.
//

import Foundation
import Swinject
import Alamofire
import Firebase

final class NetworkModule {
    private let container: Container

    init(_ container: Container) {
        self.container = container
    }

    func inject() {
        container.register(Session.self) { _ in
            AF
        }

        container.register(NetworkManager.self) { resolver in
            NetworkManagerImpl(alamofire: resolver.resolve(Session.self)!)
        }

        container.register(DatabaseReference.self) { _ in
            Database.database().reference()
        }

        container.register(DatabaseManager.self) { resolver in
            DatabaseManagerImpl(ref: resolver.resolve(DatabaseReference.self)!)
        }
    }
}
