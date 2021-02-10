//
//  TransactionsTableViewCell.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class TransactionsTableViewCell: UITableViewCell {
    
    // MARK: - Private
    
    // MARK: UI
    
    private let vendorLabel = UILabel()
    private let amountLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigurableView

extension TransactionsTableViewCell: ConfigurableView {
    
    struct Model {
        
        let vendor: String
        let amount: String
        
        init(transactionModel: TransactionModel) {
            vendor = transactionModel.vendor
            amount = transactionModel.amount
        }
        
    }
    
    func configure(model: Model) {
        vendorLabel.text = model.vendor
        amountLabel.text = model.amount
    }
    
}

// MARK: - Private functions

private extension TransactionsTableViewCell {
    
    func setupLayout() {
        layoutUsing.stack {
            $0.hStack(
                alignedTo: .center,
                $0.hGap(fixed: 16),
                vendorLabel,
                $0.hGap(min: 16),
                amountLabel,
                $0.hGap(fixed: 16)
            )
        }
    }
    
}
