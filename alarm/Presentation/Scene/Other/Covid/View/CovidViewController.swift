//
//  CovidViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import UIKit

class CovidViewController: BaseViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    
    private var covidManager     : CovidManagerProtocol!
    private var viewModel        : CovidListViewModelProtocol!
    private var dataSource       : CovidDataSource!
    
    var currentCountry : String? {
        didSet {
            title = currentCountry
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.viewDidLoad()
        spinner.startAnimating()
        imgView.image = UIImage(named: "dark_covid")
        setupLayout()
        addBindings()
        navigationItem.largeTitleDisplayMode = .never
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataSource.filteredData.removeAll()

    }
    private func setupLayout() {
        tableView.registerNib(class: ChartTableViewCell.self)
        tableView.registerNib(class: IncidentTableViewCell.self)
        tableView.registerNib(class: MortalityTableViewCell.self)
        tableView.registerNib(class: RecoveredTableViewCell.self)
        tableView.registerNib(class: DeathTableViewCell.self)
        tableView.registerNib(class: CovidConfirmedTableViewCell.self)
        tableView.registerNib(class: ActiveTableViewCell.self)
    }
    
    private func configureViewModel() {
        covidManager     = CovidManager()
        viewModel        = CovidListViewModel(controller: self, covidManager: covidManager)
        dataSource       = CovidDataSource(with: tableView, viewModel: viewModel, countryName: currentCountry ?? "-")
    }
    
    private func addBindings() {
        viewModel.didStartLoading = { [weak self] in
            self?.spinner.startAnimating()
        }
        viewModel.didFinishLoading = { [weak self] in
            self?.dataSource.refresh()
            self?.spinner.stopAnimating()
        }
    }
}
