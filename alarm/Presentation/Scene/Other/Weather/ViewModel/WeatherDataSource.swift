//
//  WeatherDataSource.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//


import UIKit
import Kingfisher

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var tableView: UITableView!
    private var viewModel: WeatherListViewModelProtocol!
         
    var coordinator  : CoordinatorProtocol?
    var weather : Weather?
    
    init(with tableView: UITableView, viewModel: WeatherListViewModelProtocol) {
        super.init()
        
        self.tableView            = tableView
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.viewModel            = viewModel
    }
    
    func refresh() {
        weather = viewModel.weather
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.deque(MainCell.self, for: indexPath)
            cell.labelCity.text        = "\(weather.map { $0.location.name} ?? "-")"
            cell.labelTemperature.text = "\(weather.map { $0.current.temperature } ?? 0)°"
            cell.labelCondition.text   = "\(weather.map { $0.current.condition.text} ?? "-")"

            cell.selectionStyle = .none

            return cell        }
        
        if indexPath.row == 1 {
            let cell = tableView.deque(HourlyCell.self, for: indexPath)
            if let weath = weather {
                cell.updateCellWith(row: weath)
            }
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            cell.alpha = 0.0
            return cell
        }

        if indexPath.row == 2 {
            let cell = tableView.deque(SunriseCell.self, for: indexPath)
            cell.labelSunrise.text = "\(weather.map { $0.forecast.forecastday.map {$0.astro.sunrise} } ?? ["-"] )"
            cell.labelSunrise.text?.removeFirst()
            cell.labelSunrise.text?.removeFirst()
            cell.labelSunrise.text?.removeLast()
            cell.labelSunrise.text?.removeLast()
            cell.sunriseOutlet.text = "sunriseLabel".localized()
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(SunsetCell.self, for: indexPath)
            cell.labelSunset.text = "\(weather.map { $0.forecast.forecastday.map {$0.astro.sunset} } ?? ["-"] )"
            cell.labelSunset.text?.removeFirst()
            cell.labelSunset.text?.removeFirst()
            cell.labelSunset.text?.removeLast()
            cell.labelSunset.text?.removeLast()
            cell.sunsetOutlet.text = "sunsetLabel".localized()

            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.deque(HumidityCell.self, for: indexPath)
            cell.labelHumidity.text = "\(weather.map { $0.current.humidity } ?? 0)%"
            cell.humidityOutlet.text = "humidityLabel".localized()
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.deque(ChanceofRainCell.self, for: indexPath)
            cell.labelRain.text = "\(weather.map { $0.current.pressure} ?? 0)%"
            cell.rainOutlet.text = "rainLabel".localized()
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 6 {
            let cell = tableView.deque(WindCell.self, for: indexPath)
            cell.labelWind.text = "\(weather.map { $0.current.windSpeed} ?? 0)"+"speedString".localized()
            cell.windOutlet.text = "windLabel".localized()
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 7 {
            let cell = tableView.deque(FeelsLikeCell.self, for: indexPath)
            cell.labelFeelsLike.text = "\(weather.map { $0.current.feelslike} ?? 0)°"
            cell.feelsLikeOutlet.text = "feelsLikeLabel".localized()
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 8 {
            let cell = tableView.deque(PressureCell.self, for: indexPath)
            cell.labelPressure.text = "\(weather.map { $0.current.pressure} ?? 0)"+"pressureString".localized()
            cell.pressureOutlet.text = "pressureLabel".localized()
            cell.selectionStyle = .none

            return cell
        }
        else {
            let cell = tableView.deque(MapCell.self, for: indexPath)
            cell.locationLabel.text = "countryLocationLabel".localized()
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
        else if indexPath.row == 1 { return 140 }
        else                       { return 90  }
    }
}



extension WeatherDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 9 {
              let sb = UIStoryboard(name: "MapViewController", bundle: nil)
              let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
  
            vc.latitude  =  weather.map { $0.location.lat  }
            vc.longitude =  weather.map { $0.location.lon }
            viewModel.controller.navigationController?.pushViewController(vc, animated: true)
          }
    }
}
