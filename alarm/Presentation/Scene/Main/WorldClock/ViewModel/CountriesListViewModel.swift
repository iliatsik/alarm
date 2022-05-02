//
//  CountriesListViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//
import UIKit

protocol CountriesListViewModelProtocol: AnyObject {
    var didFinishLoading: (() -> Void)?   { get set }
    var didStartLoading: (() -> Void)?    { get set }
    var controller: CoordinatorDelegate   { get }
    func viewDidLoad()
    var countries : [CountryViewModel]    { get }
    
    init(with countriesManager: CountriesManagerProtocol, controller: CoordinatorDelegate, covidManager: CovidManagerProtocol, weatherManager: WeatherManagerProtocol)
}

final class CountriesListViewModel : CountriesListViewModelProtocol {
   
    private(set) var controller  : CoordinatorDelegate
    private(set) var countries = [CountryViewModel]()

    private var countriesManager : CountriesManagerProtocol!
    private var covidManager     : CovidManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
        
    var didFinishLoading: (() -> Void)? 
    var didStartLoading:  (() -> Void)?
    
    init(with countriesManager: CountriesManagerProtocol, controller: CoordinatorDelegate, covidManager: CovidManagerProtocol, weatherManager: WeatherManagerProtocol)  {
        self.countriesManager = countriesManager
        self.controller       = controller
        self.covidManager     = covidManager
        self.weatherManager   = weatherManager
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
        self.didStartLoading?()

        countriesManager.fetchCountries { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self?.countries = countries.map { CountryViewModel(country: $0 ) }
                    self?.didFinishLoading?()
                case .failure(let error):
                    self?.showErrorMessage()
                    self?.didFinishLoading?()
                    print(error)
                }
            }
        }
    }
}
