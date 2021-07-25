//
//  CovidViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import UIKit

class CovidViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    
    private var covidManager     : CovidManagerProtocol!
    private var viewModel        : CovidListViewModelProtocol!
    private var dataSource       : CovidDataSource!
    
    var currentCountry : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UIImage(named: "covid")
        setupLayout()
        configureViewModel()
        dataSource.refresh()
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
        dataSource       = CovidDataSource(with: tableView, viewModel: viewModel, countryName: currentCountry ?? "Georgia")
    }
}
