//
//  ViewModelCovid.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit


protocol CovidListViewModelProtocol: AnyObject {
    var didFinishedLoading: (() -> Void)? { get set }
    var navigationItem: UINavigationItem? { get set }
    func setTitle(with text: String, on navigationItem: UINavigationItem)
    var controller: CoordinatorDelegate { get }
    
 
    init(controller: CoordinatorDelegate)
}

final class CovidListViewModel: CovidListViewModelProtocol {
   
    private(set) var controller: CoordinatorDelegate
    
    private var countriesManager : CountriesManagerProtocol!
    private var covidManager     : CovidManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    var didFinishedLoading: (() -> Void)?
    var navigationItem: UINavigationItem?
    
    init(controller: CoordinatorDelegate)  {
        self.controller       = controller
    }
    
  
    func setTitle(with text: String, on navigationItem: UINavigationItem) {
        navigationItem.title = text
    }
}


