//
//  TransactionsTableView.swift
//  PayDay
//
//  Created by Vlad Shostak on 10.02.2021.
//  Copyright © 2021 Vlad Shostak. All rights reserved.
//

import UIKit

final class TransactionsTableView: UITableView {
    
    // MARK: - Private
    
    // MARK: Typealises
    
    typealias Model = [DailyTransactionsModel]
    typealias Cell = TransactionsTableViewCell
    
    // MARK: Variables
    
    private var model: Model?
    
    private let identifier = String(describing: Cell.self)
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    func reload(model: Model) {
        self.model = model
        
        reloadData()
    }
    
}

// MARK: - UITableViewDelegate

extension TransactionsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.height
    }
    
}

// MARK: - UITableViewDataSource

extension TransactionsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?[section].transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell,
            let transactionModel = model?[indexPath.section].transactions[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.configure(
            model: TransactionsTableViewCell.Model(
                transactionModel: transactionModel
            )
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let date = model?[section].date else { return nil }
        
        if DateFormatterHelper.isTodayDate(date) {
            return "Today"
        }
        
        if DateFormatterHelper.isYesterdayDate(date) {
            return "Yesterday"
        }
        
        return DateFormatterHelper.transactionGroupDateString(from: date)
    }
    
}

// MARK: - Private functios

private extension TransactionsTableView {
    
    func setupView() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        
        register(Cell.self, forCellReuseIdentifier: identifier)
    }
    
}

// MARK: - Constants

private extension TransactionsTableView {
    
    enum Constants {
        static let height: CGFloat = 60
    }
    
}
