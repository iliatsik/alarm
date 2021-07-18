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
    
    init(with countriesManager: CountriesManagerProtocol, controller: CoordinatorDelegate)
}

final class CountriesListViewModel: CountriesListViewModelProtocol {
        
    private(set) var controller: CoordinatorDelegate
    
    private var countriesManager: CountriesManagerProtocol!
    var didFinishedLoading: (() -> Void)?
    var navigationItem: UINavigationItem?
    
    init(with countriesManager: CountriesManagerProtocol, controller: CoordinatorDelegate )  {
        self.countriesManager = countriesManager
        self.controller       = controller
    }
    
    func getCountriesList(completion: @escaping (([CountryViewModel]) -> Void)) {
        countriesManager.fetchCountries { countries in

            DispatchQueue.main.async {
                    let countriesViewModels =  countries.map { CountryViewModel(country: $0 ) }
                    completion(countriesViewModels)
           }
        }
    }
    
    func setTitle(with text: String, on navigationItem: UINavigationItem) {
        navigationItem.title = text
    }
}
