//
//  WorldClockViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 05.06.21.
//

import UIKit

class WorldClockViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: CountriesListViewModelProtocol!
    private var dataSource: CountriesDataSource!
    private var countriesManager: CountriesManagerProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bindings()
        setupLayout()
        configureViewModel()
        dataSource.refresh()
        viewModel.setTitle(with: "Countries", on: navigationItem)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupLayout() {
        searchBar.delegate = self
        tableView.registerNib(class: CountryTableViewCell.self)
    }
    
    private func configureViewModel() {
        countriesManager = CountriesManager()
        viewModel = CountriesListViewModel(with: countriesManager, controller: self)
        dataSource = CountriesDataSource(with: tableView, viewModel: viewModel)
    }
}

extension WorldClockViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.search(with: searchText)
    }
}
