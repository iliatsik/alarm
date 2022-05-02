//
//  WeatherViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import UIKit


protocol WeatherListViewModelProtocol: AnyObject {
    var didFinishLoading: (() -> Void)?   { get set }
    var didStartLoading:  (() -> Void)?   { get set }
    var controller: CoordinatorDelegate { get }
    func viewDidLoad()
    var weather: Weather? { get }
}

final class WeatherListViewModel: WeatherListViewModelProtocol {
   
    private(set) var controller: CoordinatorDelegate
    
    private var countriesManager : CountriesManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    var didFinishLoading: (() -> Void)?
    var didStartLoading:  (() -> Void)?
    private let cityName : String
    private(set) var weather : Weather?
    
    init(controller: CoordinatorDelegate, weatherManager: WeatherManagerProtocol, cityName: String)  {
        self.controller     = controller
        self.weatherManager = weatherManager
        self.cityName       = cityName
    }
    
    private func showErrorMessage() {
        var actions = [AlertAction]()
        actions.append(AlertAction(title: "retryForAlert".localized(), action: { [weak self] in
            self?.fetchData()
        }))
        actions.append(AlertAction(title: "okButtonTitle".localized(), action: { }))
        self.controller.coordinator?.presentAlert(title: "errorAlertTitle".localized(), message: nil, actions: actions)
    }

    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        didStartLoading?()
    
        weatherManager.fetchWeatherLocation(with: cityName) { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let response):
                    self?.weather = response
                    self?.didFinishLoading?()
                case .failure(let err):
                    self?.showErrorMessage()
                    self?.didFinishLoading?()
                    print(err)
                }
            }
        }
    }
}
