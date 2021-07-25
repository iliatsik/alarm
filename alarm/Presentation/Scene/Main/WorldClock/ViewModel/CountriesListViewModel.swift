//
//  CountriesListViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//
import UIKit

protocol CountriesListViewModelProtocol: AnyObject {
    func getCountriesList(completion: @escaping (([CountryViewModel]) -> Void))
    var didFinishedLoading: (() -> Void)? { get set }
    var navigationItem: UINavigationItem? { get set }
    func setTitle(with text: String, on navigationItem: UINavigationItem)
    var controller: CoordinatorDelegate { get }
    
    func getWeatherData(with cityname: String,completion: @escaping ((ForecastViewModel) -> Void))
    
    init(with countriesManager: CountriesManagerProtocol, controller: CoordinatorDelegate, covidManager: CovidManagerProtocol, weatherManager: WeatherManagerProtocol)
}

final class CountriesListViewModel: CountriesListViewModelProtocol {
   
    private(set) var controller: CoordinatorDelegate
    
    private var countriesManager : CountriesManagerProtocol!
    private var covidManager     : CovidManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    var didFinishedLoading: (() -> Void)?
    var navigationItem: UINavigationItem?
    
    init(with countriesManager: CountriesManagerProtocol, controller: CoordinatorDelegate, covidManager: CovidManagerProtocol, weatherManager: WeatherManagerProtocol)  {
        self.countriesManager = countriesManager
        self.controller       = controller
        self.covidManager     = covidManager
        self.weatherManager   = weatherManager
    }
    
    func getCountriesList(completion: @escaping (([CountryViewModel]) -> Void)) {
        countriesManager.fetchCountries { countries in

            DispatchQueue.main.async {
                let countriesViewModels =  countries.map { CountryViewModel(country: $0 ) }
                completion(countriesViewModels)
           }
        }
    }
    
    func getWeatherData(with cityname: String, completion: @escaping ((ForecastViewModel) -> Void)) {

        weatherManager.fetchWeatherLocation(with: cityname) { result in
            DispatchQueue.main.async {
//                let weatherViewModel = result.forecast.forecastday.map  { ForecastViewModel(weather: $0 ) }
//                completion(weatherViewModel)
            }
        }
    }
    
    func setTitle(with text: String, on navigationItem: UINavigationItem) {
        navigationItem.title = text
    }
}
