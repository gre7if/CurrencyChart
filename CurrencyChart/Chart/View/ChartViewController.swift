//
//  ChartViewController.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import UIKit
import Charts

protocol ChartViewControllerInput: AnyObject {
    func configureUI()
    func setupView(viewModel: ChartViewModel)
}

protocol ChartViewControllerOutput {
    func prepareData(pair: String)
    func stopUpdatingData()
}

class ChartViewController: UIViewController, ChartViewControllerInput {
    
    var presenter: ChartViewControllerOutput
    var pair = String()
    
    private lazy var contentView = ChartView()
    
    init(presenter: ChartViewControllerOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        presenter.stopUpdatingData()
    }
    
    func setupView(viewModel: ChartViewModel) {
        contentView.update(viewModel: viewModel)
    }
    
    func configureUI() {
        title = pair
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        presenter.prepareData(pair: pair)
    }
}



