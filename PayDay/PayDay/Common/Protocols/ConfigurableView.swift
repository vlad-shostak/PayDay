//
//  ConfigurableView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

/// Describes a view, which can be configured with some model.
protocol ConfigurableView: AnyObject {
    
    associatedtype Model
    
    /// Configures the view with specified model.
    ///
    /// - Parameter model: The model object.
    func configure(model: Model)
    
}

extension ConfigurableView {
    
    func configured(with model: Model) -> Self {
        configure(model: model)
        
        return self
    }
    
}
