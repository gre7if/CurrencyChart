//
//  PairsTableViewCell.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import UIKit

class PairsTableViewCell: UITableViewCell {
    
    static let identifier = "PairsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with text: String) {
        textLabel?.text = text
    }
}
