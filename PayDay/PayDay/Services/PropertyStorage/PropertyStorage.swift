//
//  PropertyStorage.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

struct PropertyStorage {
    
    // MARK: - Private variables

    private let storage = UserDefaults.standard
    
}

// MARK: - PropertyStorageProtocol

extension PropertyStorage: PropertyStorageProtocol {
    
    func set<T>(_ value: T, forKey key: String) {
        storage.set(value, forKey: key)
    }
    
    func get<T>(forKey key: String) -> T? {
        storage.value(forKey: key) as? T
    }
    
}
