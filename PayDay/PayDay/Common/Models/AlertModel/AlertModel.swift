//
//  AlertModel.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

struct AlertViewModel {
    
    struct Action {
        
        enum Style {
            case confirm
            case cancel
            case destructive
        }
        
        let title: String
        let style: Style
        let completion: (() -> Void)?
        
        init(title: String, style: Style, completion: (() -> Void)?) {
            self.title = title
            self.style = style
            self.completion = completion
        }
        
    }
    
    let title: String?
    let message: String?
    let actions: [Action]
    
    public init(title: String?,
                message: String? = nil,
                actions: [Action]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
}

