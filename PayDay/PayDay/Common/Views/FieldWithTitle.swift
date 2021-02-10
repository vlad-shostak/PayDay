//
//  FieldWithTitle.swift
//  PayDay
//
//  Created by Vlad Shostak on 09.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class FieldWithTitle: UIView {
    
    // MARK: - Public
    
    // MARK: Typealises
    
    typealias FieldValueChangeCompletion = (String) -> Void
    
    // MARK: - Private
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    
    private let textField = TextFieldWithInsets()
        .decorated(with: .default)
        .decorated(with: .textInsets(.insets(top: 8, left: 8, bottom: 8, right: 8)))
    
    // MARK: Variables
    
    private var onValueChange: FieldValueChangeCompletion?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupTextField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigurableView

extension FieldWithTitle: ConfigurableView {
    
    struct Model {
        let title: String
        let placeholder: String
        let textContentType: UITextContentType?
        let keyboardType: UIKeyboardType
        let isSecureTextEntry: Bool
        let onValueChange: FieldValueChangeCompletion
        
        init(title: String,
             placeholder: String,
             textContentType: UITextContentType? = nil,
             keyboardType: UIKeyboardType = .default,
             isSecureTextEntry: Bool = false,
             onValueChange: @escaping FieldValueChangeCompletion) {
            self.title = title
            self.placeholder = placeholder
            self.textContentType = textContentType
            self.keyboardType = keyboardType
            self.isSecureTextEntry = isSecureTextEntry
            self.onValueChange = onValueChange
        }
    }
    
    func configure(model: Model) {
        titleLabel.text = model.title
        
        textField.placeholder = model.placeholder
        textField.textContentType = model.textContentType
        textField.keyboardType = model.keyboardType
        textField.isSecureTextEntry = model.isSecureTextEntry
        
        onValueChange = model.onValueChange
    }
    
}

// MARK: - Private functions

private extension FieldWithTitle {
    
    func setupLayout() {
        layoutUsing.stack {
            $0.vStack(
                titleLabel,
                $0.vGap(fixed: 4),
                textField
            )
        }
    }
    
    func setupTextField() {
        textField.clearButtonMode = .whileEditing
        
        textField.addTarget(
            self,
            action: #selector(textFieldValueChanged),
            for: .editingChanged
        )
    }
    
    @objc
    func textFieldValueChanged() {
        guard let text = textField.text else { return }
        
        onValueChange?(text)
    }
    
}

// MARK: - Constants

private extension FieldWithTitle {
    
    enum Constants {
        
        enum TextField {
            static let heigth: CGFloat = 50
            static let cornerRadius = heigth / 3
        }
        
    }
    
}
