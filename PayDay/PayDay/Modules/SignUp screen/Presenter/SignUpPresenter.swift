//
//  SignUpPresenter.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

final class SignUpPresenter {
    
    // MARK: - Private
    
    // MARK: External dependencies
    
    private unowned let view: SignUpScreenInput
    private let interactor: SignUpInteractorProtocol
    private let router: SignUpRouterProtocol
    
    // MARK: Variables
    
    private var state = State(signUpModel: .empty)
    
    // MARK: - Initialization
    
    init(view: SignUpScreenInput,
         interactor: SignUpInteractorProtocol,
         router: SignUpRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - SignUpScreenOutput

extension SignUpPresenter: SignUpScreenOutput {
    
    func didAskToSignIn() {
        router.routeToSignIn()
    }
    
}

// MARK: - LifecycleListener

extension SignUpPresenter: LifecycleListener {
    
    func viewDidLoad() {
        view.configureScreen(with: screenModel)
    }
    
}

// MARK: - Private functions

private extension SignUpPresenter {
    
    var firstNameModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "First name",
            placeholder: "Enter your first name",
            textContentType: .name
        ) { [weak self] firstName in
            self?.state.signUpModel?.firstName = firstName
        }
    }
    
    var lastNameModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "Last name",
            placeholder: "Enter your last name",
            textContentType: .name
        ) { [weak self] lastName in
            self?.state.signUpModel?.lastName = lastName
        }
    }
    
    var phoneNumberModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "Phone number",
            placeholder: "Enter your phone number",
            textContentType: .telephoneNumber,
            keyboardType: .phonePad
        ) { [weak self] phoneNumber in
            self?.state.signUpModel?.phoneNumber = phoneNumber
        }
    }
    
    var emailModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "Email",
            placeholder: "Enter your email",
            textContentType: .emailAddress,
            keyboardType: .emailAddress
        ) { [weak self] email in
            self?.state.signUpModel?.email = email
        }
    }
    
    var passwordModel: FieldWithTitle.Model {
        FieldWithTitle.Model(
            title: "Password",
            placeholder: "Enter your password",
            textContentType: .password,
            isSecureTextEntry: true
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
    
    var signUpButtonModel: BaseButtonModel {
        BaseButtonModel(
            title: "Sign Up"
        ) { [weak self] in
            self?.signUp()
        }
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
                .gap(height: 16),
                .button(model: signUpButtonModel)
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
