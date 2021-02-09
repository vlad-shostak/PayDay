//
//  SignUpInteractorProtocol.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation

protocol SignUpInteractorProtocol {
    
    func register(with model: SignUpModel, completion: @escaping (Result<Int>) -> Void)
    
}
