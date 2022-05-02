//
//  WorldClockViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 05.06.21.
//

import UIKit

class WorldClockViewController: BaseViewController {

    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView : UITableView!

    private var viewModel        : CountriesListViewModelProtocol!
    private var dataSource       : CountriesDataSource?
    private var countriesManager : CountriesManagerProtocol!
    private var covidManager     : CovidManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "worldClockTitle".localized()
        setupLayout()
        configureViewModel()
        addBindings()
        viewModel.viewDidLoad()
    }
 
    private func setupLayout() {
        searchBar.delegate = self
        tableView.registerNib(class: CountryTableViewCell.self)
        searchBar.barTintColor = .black
        searchBar.backgroundColor = .black
    }
    
    private func configureViewModel() {
        weatherManager   = WeatherManager()
        countriesManager = CountriesManager()
        covidManager     = CovidManager()
        viewModel        = CountriesListViewModel(with:           countriesManager,
                                                  controller:     self,
                                                  covidManager:   covidManager,
                                                  weatherManager: weatherManager)
        dataSource       = CountriesDataSource(with: tableView, viewModel: viewModel)
    }
    
    private func addBindings() {
        viewModel.didStartLoading = { [weak self] in
            self?.spinner.startAnimating()
        }
        viewModel.didFinishLoading = { [weak self] in
            self?.dataSource?.refresh()
            self?.spinner.stopAnimating()
        }
    }
}

extension WorldClockViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource?.search(with: searchText)
    }
}
