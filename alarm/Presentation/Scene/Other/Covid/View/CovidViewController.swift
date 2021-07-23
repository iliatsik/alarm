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
    
    private var covidList = [Covid]()
    private var covidManager : CovidManagerProtocol!
    private var viewModel        : CovidListViewModelProtocol!
    private var dataSource       : CovidDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager = CovidManager()
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
        viewModel        = CovidListViewModel(controller: self)
        dataSource       = CovidDataSource(with: tableView, viewModel: viewModel)
    }
    


    
    func configure(with item: CovidViewModel) {
        DispatchQueue.main.async {
//            self.labelActive.text    = "Active: \(item.active)"
//            self.labelDeaths.text    = "Death: \(item.death)"
//            self.labelRecovered.text = "Recovored: \(item.recovered )"
//            self.labelConfirmed.text = "Confirmed: \(item.confirmed)"
        }
    }
}
