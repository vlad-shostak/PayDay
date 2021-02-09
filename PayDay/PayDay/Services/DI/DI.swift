//
//  DI.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

/// This class is a container for dependencies.
/// It encapsulates the creation and lifetime of objects.
final class DI {
    
    // MARK: - Private variables
    
    private static let sharedInstance = DI()
    
    private var dependencies: [String: Any] = [:]
    
    // MARK: - Public variables
    
    /// Returns the shared instance of the DI.
    ///
    /// This is not constant, because constant has a concrete type.
    /// This generic function forces to specify a type of the container using protocols.
    /// If you don't specify a type you'll get the error "Generic parameter T could not by inferred".
    static func shared<T>() -> T {
        sharedInstance as! T
    }
    
    // MARK: - Public functions
    
    /// Returns an instance of a dependency by the specified key. If dependency is not exists, the `create` closure will be called.
    ///
    /// This function resolves the problem with stored properties in extensions.
    ///
    /// - Parameter key: The key of a dependency.
    /// - Parameter create: A closure, that called to create an instance of a dependency if it's not created yet.
    func stored<T>(by key: String, create: () -> T) -> T {
        if let dependency = dependencies[key] as? T {
            return dependency
        } else {
            let dependency = create()
            
            dependencies[key] = dependency
            
            return dependency
        }
    }
    
    func removeAll() {
        dependencies.removeAll()
    }
    
}
