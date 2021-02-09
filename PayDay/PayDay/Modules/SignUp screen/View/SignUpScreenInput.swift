//
//  SignUpScreenInput.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

protocol SignUpScreenInput: AlertViewTrait {
    
    func configureScreen(with model: SignUpScreen.Model)
    
}
