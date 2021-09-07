//
//  PairsViewController.swift
//  CurrencyChart
//
//  Created by Rustam Nigmatzyanov on 06.09.2021.
//

import UIKit

class PairsViewController: UIViewController {
    
    private lazy var fetcher = HttpClient()
    
    var pairsModel: [String] = []
    private var pairsModelsSaved: [String] = []
    
    private let contentView = PairsView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var tableView: UITableView { contentView.tableView }
    private var spinner: UIActivityIndicatorView { contentView.spinner }
    
    private func configureUI() {
        title = "Currency pairs"
        navigationController?.navigationBar.prefersLargeTitles = true
        // убираем полупрозрачность заголовка
        navigationController?.navigationBar.isTranslucent = false
        // делаем стиль черным, чтобы все, что внутри, стало белым (заголовок и строка состояния)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        // settings for searchController
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.definesPresentationContext = true
        tableView.delegate = self
        tableView.dataSource = self
}
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        spinner.startAnimating()
        fetcher.fetchPairsList { pairs in
            DispatchQueue.main.async {
                self.pairsModel = pairs
                self.pairsModelsSaved = pairs
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

extension PairsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pairsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: PairsTableViewCell.identifier, for: indexPath) as? PairsTableViewCell,
            let pair = pairsModel[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configureCell(with: pair)
        return cell
    }
}

extension PairsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let pair = pairsModel[safe: indexPath.row] else { return }
        let chartVC = ChartViewController()
        chartVC.pair = pair
        navigationController?.pushViewController(chartVC, animated: true)
    }
}

extension PairsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        perform(#selector(reload), with: nil, afterDelay: 0.5)
    }
    
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        
        if !text.isEmpty {
            // делаем новый запрос
            pairsModel = pairsModelsSaved.filter {
                $0.localizedCaseInsensitiveContains(text)
            }
            tableView.reloadData()
        } else {
            // возвращаем начальный запрос
            pairsModel = pairsModelsSaved
            tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        pairsModel = pairsModelsSaved
        tableView.reloadData()
    }
}
