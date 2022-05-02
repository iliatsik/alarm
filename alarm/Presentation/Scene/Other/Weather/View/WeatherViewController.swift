//
//  WeatherViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import UIKit

class WeatherViewController: BaseViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var weatherManager  : WeatherManagerProtocol!
    private var viewModel       : WeatherListViewModelProtocol!
    private var dataSource      : WeatherDataSource!

    var currentCountry: String? {
        didSet {
            title = currentCountry
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "sky")
        tableView.backgroundColor = .clear
        tableView.separatorColor  = .white
        tableView.tintColor       = .white
        spinner.startAnimating()
        configureViewModel()
        setupLayout()
        addBindings()
        viewModel.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureViewModel() {
        weatherManager   = WeatherManager()
        viewModel        = WeatherListViewModel(controller: self, weatherManager: weatherManager, cityName: currentCountry ?? "Georgia")
        dataSource       = WeatherDataSource(with: tableView, viewModel: viewModel)
    }
    
    private func setupLayout() {
        tableView.registerNib(class: MainCell.self)
        tableView.registerNib(class: HourlyCell.self)
        tableView.registerNib(class: SunriseCell.self)
        tableView.registerNib(class: SunsetCell.self)
        tableView.registerNib(class: HumidityCell.self)
        tableView.registerNib(class: ChanceofRainCell.self)
        tableView.registerNib(class: WindCell.self)
        tableView.registerNib(class: FeelsLikeCell.self)
        tableView.registerNib(class: PressureCell.self)
        tableView.registerNib(class: MapCell.self)
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
