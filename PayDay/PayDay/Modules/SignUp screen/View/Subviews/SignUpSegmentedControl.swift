//
//  SignUpSegmentedControl.swift
//  PayDay
//
//  Created by Vlad Shostak on 08.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class SignUpSegmentedControl: UIView {
    
    // MARK: - Public
    
    // MARK: Typealises
    
    typealias SegmentedControlChangeCompletion = (String) -> Void
    
    // MARK: - Private
    
    // MARK: UI
    
    private let titleLabel = UILabel()
    private let segmentedControl = UISegmentedControl()
    
    // MARK: Variables
    
    private var onChange: SegmentedControlChangeCompletion?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupSegmentedControl()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigurableView

extension SignUpSegmentedControl: ConfigurableView {
    
    struct Model {
        
        let title: String
        let controls: [String]
        let onChange: SegmentedControlChangeCompletion
        
    }
    
    func configure(model: Model) {
        titleLabel.text = model.title
        
        configureSegmentedControls(model.controls)
        
        onChange = model.onChange
    }
    
}

// MARK: - Private functions

private extension SignUpSegmentedControl {
    
    func setupLayout() {
        layoutUsing.stack {
            $0.vStack(
                titleLabel,
                $0.vGap(fixed: 8),
                segmentedControl
            )
        }
    }
    
    func setupSegmentedControl() {
        segmentedControl.addTarget(
            self,
            action: #selector(segmentedControlValueChanged(sender:)),
            for: .valueChanged
        )
    }
    
    func configureSegmentedControls(_ controls: [String]) {
        controls.enumerated().forEach {
            segmentedControl.insertSegment(
                withTitle: $1,
                at: $0,
                animated: true
            )
        }
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc
    func segmentedControlValueChanged(sender: UISegmentedControl) {
        guard
            let title = segmentedControl.titleForSegment(at: sender.selectedSegmentIndex)
        else {
            return
        }
        
        onChange?(title)
    }
    
}
