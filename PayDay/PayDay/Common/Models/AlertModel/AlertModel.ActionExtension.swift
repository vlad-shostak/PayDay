//
//  AlertModel.ActionExtension.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

extension AlertViewModel.Action {
    
    /// Cancel style "OK"
    public static func ok(_ completion: (() -> Void)? = nil) -> AlertViewModel.Action {
        AlertViewModel.Action(title: "OK", style: .cancel, completion: completion)
    }
    
    /// Cancel style "Cancel"
    public static func cancel(_ completion: (() -> Void)? = nil) -> AlertViewModel.Action {
        AlertViewModel.Action(title: "Cancel", style: .cancel, completion: completion)
    }
    
}
