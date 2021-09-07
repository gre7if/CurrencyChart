//
//  PairsListView.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import UIKit
import SnapKit

class PairsView: UIView {
        
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PairsTableViewCell.self, forCellReuseIdentifier: PairsTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private(set) lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func addSubviews() {
        tableView.addSubview(spinner)
        addSubview(tableView)
    }
    
    private func makeConstraints() {
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
