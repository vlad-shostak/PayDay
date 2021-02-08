//
//  BaseScreen.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import Foundation
import UIKit

class BaseScreen: UIViewController {
    
    // MARK: - Private variables
    
    private var lifecycleListeners: [LifecycleListener] = []
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendLifecycleListenerEvent {
            $0.viewDidLoad()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sendLifecycleListenerEvent {
            $0.viewWillAppear()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sendLifecycleListenerEvent {
            $0.viewDidAppear()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sendLifecycleListenerEvent {
            $0.viewWillDisappear()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        sendLifecycleListenerEvent {
            $0.viewDidDisappear()
        }
    }
    
    // MARK: - Public functions
    
    func addLifecycleListener(_ listener: LifecycleListener) {
        lifecycleListeners.append(listener)
    }
    
    func sendLifecycleListenerEvent(_ event: (LifecycleListener) -> Void) {
        lifecycleListeners.forEach {
            event($0)
        }
    }
    
}
