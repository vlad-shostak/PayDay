//
//  SignInPresenter.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignInPresenter {
    
    // MARK: - Private
    
    // MARK: External dependencies
    
    private unowned let view: SignInScreenInput
    private let interactor: SignInInteractorProtocol
    private let router: SignInRouterProtocol
    
    // MARK: Variables
    
    private var state = State()
    
    // MARK: - Initialization
    
    init(view: SignInScreenInput,
         interactor: SignInInteractorProtocol,
         router: SignInRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - SignInScreenOutput

extension SignInPresenter: SignInScreenOutput {}

// MARK: - LifecycleListener

extension SignInPresenter: LifecycleListener {
    
    func viewDidLoad() {
        view.configureScreen(with: screenModel)
    }
    
}

// MARK: - Private functions

private extension SignInPresenter {
    
    var emailModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "Email",
            placeholder: "Enter your email",
            textContentType: .emailAddress,
            keyboardType: .emailAddress
        ) { [weak self] email in
            self?.state.email = email
        }
    }
    
    var passwordModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "Password",
            placeholder: "Enter your password",
            textContentType: .password,
            isSecureTextEntry: true
        ) { [weak self] password in
            self?.state.password = password
        }
    }
    
    var signInButtonModel: BaseButtonModel {
        BaseButtonModel(
            title: "Sign In"
        ) { [weak self] in
            self?.signIn()
        }
    }
    
    var signUpButtonModel: BaseButtonModel {
        BaseButtonModel(
            title: "Sign Up"
        ) { [weak self] in
            self?.router.routeToSignUp()
        }
    }
    
    var screenModel: SignInScreen.Model {
        SignInScreen.Model(
            subviewRepresentations: [
                .field(model: emailModel),
                .field(model: passwordModel),
                .gap(height: 16),
                .button(model: signUpButtonModel),
                .gap(height: 4),
                .button(model: signInButtonModel)
            ]
        )
    }
    
    func signIn() {
        let email = state.email
        let password = state.password
        
        guard !email.isEmpty else {
            return showErrorAlert(with: "Please, fulfill email field")
        }
        
        guard !password.isEmpty else {
            return showErrorAlert(with: "Please, fulfill password field")
        }
        
        interactor.signIn(
            email: email,
            password: password
        ) { [weak self] result in
            switch result {
            case .success:
                self?.router.routeToTransactions()
            case .failure(let message):
                self?.showErrorAlert(with: message)
            }
        }
    }
    
    func showErrorAlert(with message: String) {
        view.showAlert(
            title: "Error",
            message: message,
            actions: [.ok()]
        )
    }
    
}
