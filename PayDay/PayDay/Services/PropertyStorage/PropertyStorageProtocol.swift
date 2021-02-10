//
//  PropertyStorageProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

protocol PropertyStorageProtocol {
    
    func set<T>(_ value: T, forKey key: String)
    func get<T>(forKey key: String) -> T?
    
}
