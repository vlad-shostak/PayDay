//
//  SignUpPresenter.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignUpPresenter {
    
    // MARK: - External dependencies
    
    unowned var view: SignUpScreenInput!
    var interactor: SignUpInteractorProtocol!
    var router: SignUpRouterProtocol!
    
    // MARK: - Private variables
    
    private var state = State(signUpModel: .empty)
    
}

// MARK: - SignUpScreenOutput

extension SignUpPresenter: SignUpScreenOutput {}

// MARK: - LifecycleListener

extension SignUpPresenter: LifecycleListener {
    
    func viewDidLoad() {
        view.configureScreen(with: screenModel)
    }
    
}

// MARK: - Private functions

private extension SignUpPresenter {
    
    var firstNameModel: SignUpField.Model {
        SignUpField.Model(
            title: "First name",
            placeholder: "Enter your first name"
        ) { [weak self] firstName in
            self?.state.signUpModel?.firstName = firstName
        }
    }
    
    var lastNameModel: SignUpField.Model {
        SignUpField.Model(
            title: "Last name",
            placeholder: "Enter your last name"
        ) { [weak self] lastName in
            self?.state.signUpModel?.lastName = lastName
        }
    }
    
    var phoneNumberModel: SignUpField.Model {
        SignUpField.Model(
            title: "Phone number",
            placeholder: "Enter your phone number"
        ) { [weak self] phoneNumber in
            self?.state.signUpModel?.phoneNumber = phoneNumber
        }
    }
    
    var emailModel: SignUpField.Model {
        SignUpField.Model(
            title: "Email",
            placeholder: "Enter your email"
        ) { [weak self] email in
            self?.state.signUpModel?.email = email
        }
    }
    
    var passwordModel: SignUpField.Model {
        SignUpField.Model(
            title: "Password",
            placeholder: "Enter your password"
        ) { [weak self] password in
            self?.state.signUpModel?.password = password
        }
    }
    
    var genderModel: SignUpSegmentedControl.Model {
        SignUpSegmentedControl.Model(
            title: "Gender",
            controls: Gender.allCases.map { $0.rawValue }
        ) { [weak self] gender in
            self?.state.signUpModel?.gender = gender
        }
    }
    
    var dateViewModel: SignUpDateView.Model {
        SignUpDateView.Model(
            title: "Birthday"
        ) { [weak self] date in
            self?.state.signUpModel?.birthDate = date
        }
    }
    
    var signUpButtonModel: SignUpScreen.Model.ButtonModel {
        (title: "Sign Up", onTap: { [weak self] in
            self?.signUp()
        })
    }
    
    var signInButtonModel: SignUpScreen.Model.ButtonModel {
        (title: "Sign In", onTap: { [weak self] in
            self?.router.routeToSignIn()
        })
    }
    
    var screenModel: SignUpScreen.Model {
        SignUpScreen.Model(
            subviewRepresentations: [
                .field(model: firstNameModel),
                .field(model: lastNameModel),
                .field(model: phoneNumberModel),
                .field(model: emailModel),
                .field(model: passwordModel),
                .segmentedControl(model: genderModel),
                .dateView(model: dateViewModel),
                .button(model: signUpButtonModel),
                .button(model: signInButtonModel),
            ]
        )
    }
    
    func signUp() {
        guard
            let signUpModel = state.signUpModel,
            interactor.validate(password: signUpModel.password) == .success
        else {
            return showErrorAlert(
                with: "Password should have more than 5 symbols"
            )
        }
        
        interactor.signUp(
            with: signUpModel
        ) { [weak self] result in
            switch result {
            case .success:
                self?.router.routeToTransactions()
            case .failure(let message):
                self?.showErrorAlert(with: message)
            }
        }
        
    }
    
    func showErrorAlert(with message: String?) {
        view.showAlert(
            title: "Error",
            message: message,
            actions: [.ok()]
        )
    }
    
}
