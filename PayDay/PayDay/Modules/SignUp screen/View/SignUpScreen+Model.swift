//
//  SignUpScreen+Model.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

extension SignUpScreen {
    
    struct Model {
        
        typealias ButtonModel = (title: String, onTap: () -> Void)
        
        enum SubviewRepresentation {
            case field(model: SignUpField.Model)
            case segmentedControl(model: SignUpSegmentedControl.Model)
            case dateView(model: SignUpDateView.Model)
            case button(model: ButtonModel)
        }
        
        let subviewRepresentations: [SubviewRepresentation]
        
    }
    
}
