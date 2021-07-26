//
//  WeatherDataSource.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//


import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var tableView: UITableView!
    private var viewModel: WeatherListViewModelProtocol!
         
    var coordinator  : CoordinatorProtocol?
    var weather : Weather?

    var currentCountry : String?
    
    init(with tableView: UITableView, viewModel: WeatherListViewModelProtocol, countryName : String) {
        super.init()
        
        self.tableView            = tableView
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.viewModel            = viewModel
        self.currentCountry       = countryName
    }
    
    func refresh() {
        viewModel.getWeatherData(with: currentCountry ?? "Georgia") { [weak self] result in
            self?.weather = result
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.deque(MainCell.self, for: indexPath)
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell        }
        
        if indexPath.row == 1 {
            let cell = tableView.deque(HourlyCell.self, for: indexPath)
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.selectionStyle = .none
            cell.alpha = 0.0

            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.deque(WeeklyCell.self, for: indexPath)
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(SunriseCell.self, for: indexPath)
            cell.textLabel?.text = "SUNRISE: \(weather.map { $0.forecast.forecastday.map {$0.astro.sunrise} } )"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.deque(SunsetCell.self, for: indexPath)
            cell.textLabel?.text = "SUNSET:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.deque(HumidityCell.self, for: indexPath)
            cell.textLabel?.text = "HUMIDITY"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 6 {
            let cell = tableView.deque(ChanceofRainCell.self, for: indexPath)
            cell.textLabel?.text = "CHANCE OF RAIN"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 7 {
            let cell = tableView.deque(WindCell.self, for: indexPath)
            cell.textLabel?.text = "WIND"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 8 {
            let cell = tableView.deque(FeelsLikeCell.self, for: indexPath)
            cell.textLabel?.text = "FEELS LIKE"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        else {
            let cell = tableView.deque(PressureCell.self, for: indexPath)
            cell.textLabel?.text = "PRESSURE"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if      indexPath.row == 0 { return 350 }
        else if indexPath.row == 1 { return 120 }
        else if indexPath.row == 2 { return 250 }
        else                       { return 90  }
    }
}



extension WeatherDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.controller.coordinator?.didTapOnCell()
    
       
        print(indexPath.row)
    }
}
