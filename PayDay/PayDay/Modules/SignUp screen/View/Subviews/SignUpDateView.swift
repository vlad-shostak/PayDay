//
//  SignUpDateView.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class SignUpDateView: UIView {
    
    // MARK: - Public
    
    // MARK: Typealises
    
    typealias DateFieldValueChangeCompletion = (Date) -> Void
    
    // MARK: - Private
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    
    private let fieldsStackView = UIStackView()
        .decorated(with: .horizontal(16))
        .decorated(with: .distribution(.fillEqually))
    
    // MARK: Variables
    
    private var onValueChange: DateFieldValueChangeCompletion?
    
    private var dateComponent = DateComponents()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupFieldsStackView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigurableView

extension SignUpDateView: ConfigurableView {
    
    struct Model {
        
        let title: String
        let onValueChange: DateFieldValueChangeCompletion
        
    }
    
    func configure(model: Model) {
        titleLabel.text = model.title
        
        onValueChange = model.onValueChange
    }
    
}

// MARK: - Private functions

private extension SignUpDateView {
    
    func setupLayout() {
        layoutUsing.stack {
            $0.vStack(
                titleLabel,
                $0.vGap(fixed: 8),
                fieldsStackView
            )
        }
    }
    
    func setupFieldsStackView() {
        let placeholders = ["DD", "MM", "YY"]
        
        [UITextField(), UITextField(), UITextField()].enumerated().forEach {
            $1.placeholder = placeholders[$0]
            
            $1.addTarget(
                self,
                action: #selector(textFieldValueChanged),
                for: .editingChanged
            )
            
            $1
                .decorated(with: .borderColor(.black))
                .decorated(with: .borderWidth(1))
            
            fieldsStackView.addArrangedSubview($1)
        }
    }
    
    @objc
    func textFieldValueChanged() {
        let compoundText = fieldsStackView.subviews.map {
            ($0 as? UITextField)?.text ?? ""
        }
        
        dateComponent.day = Int(compoundText[0])
        dateComponent.month = Int(compoundText[1])
        dateComponent.year = Int(compoundText[2])
        
        Calendar.current.date(from: dateComponent).map {
            onValueChange?($0)
        }
    }
    
}
