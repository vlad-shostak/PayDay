//
//  SignInScreen+Model.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

extension SignInScreen {
    
    struct Model {
        
        enum SubviewRepresentation {
            case field(model: FieldWithTitle.Model)
            case button(model: BaseButtonModel)
            case gap(height: CGFloat)
        }
        
        let subviewRepresentations: [SubviewRepresentation]
        
    }
    
}
