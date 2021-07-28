//
//  WeatherViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import UIKit

class WeatherViewController: BaseViewController {
    

    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var weatherList     = [Weather]()
    private var weatherManager  : WeatherManagerProtocol!
    private var viewModel       : WeatherListViewModelProtocol!
    private var dataSource      : WeatherDataSource!

    var currentCountry        : String?


    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "sky")
        tableView.backgroundColor = .clear
        tableView.separatorColor  = .white
        tableView.tintColor       = .white
        configureViewModel()
        setupLayout()
    }
    
    private func configureViewModel() {
        weatherManager   = WeatherManager()
        viewModel        = WeatherListViewModel(controller: self,weatherManager: weatherManager)
        dataSource       = WeatherDataSource(with: tableView, viewModel: viewModel, countryName: currentCountry ?? "Georgia")
        dataSource.refresh()
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
    }

 
}
