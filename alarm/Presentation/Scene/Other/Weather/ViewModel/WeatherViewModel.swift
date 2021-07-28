//
//  WeatherViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import UIKit


protocol WeatherListViewModelProtocol: AnyObject {
    var didFinishedLoading: (() -> Void)? { get set }
    var navigationItem: UINavigationItem? { get set }
    func setTitle(with text: String, on navigationItem: UINavigationItem)
    var controller: CoordinatorDelegate { get }
    func getWeatherData(with cityname: String, completion: @escaping ((Weather) -> Void))
 
    init(controller: CoordinatorDelegate, weatherManager: WeatherManagerProtocol)
}

final class WeatherListViewModel: WeatherListViewModelProtocol {
   
    private(set) var controller: CoordinatorDelegate
    
    private var countriesManager : CountriesManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    var didFinishedLoading: (() -> Void)?
    var navigationItem: UINavigationItem?
    
    init(controller: CoordinatorDelegate, weatherManager: WeatherManagerProtocol)  {
        self.controller     = controller
        self.weatherManager = weatherManager
    }
    
    func getWeatherData(with cityname: String, completion: @escaping ((Weather) -> Void)) {
        weatherManager.fetchWeatherLocation(with: cityname, completion: completion ) 
    }
  
    func setTitle(with text: String, on navigationItem: UINavigationItem) {
        navigationItem.title = text
    }
}
