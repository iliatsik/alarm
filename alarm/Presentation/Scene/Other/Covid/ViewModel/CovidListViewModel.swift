//
//  ViewModelCovid.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit


protocol CovidListViewModelProtocol: AnyObject {
    var didFinishLoading: (() -> Void)? { get set}
    var didStartLoading:  (() -> Void)? { get set}
    var controller: CoordinatorDelegate { get }
    var covid : [Covid] { get }
    func viewDidLoad() 
    init(controller: CoordinatorDelegate, covidManager : CovidManagerProtocol) 
}

final class CovidListViewModel: CovidListViewModelProtocol {
   
    private(set) var controller: CoordinatorDelegate
    private(set) var covid = [Covid]()

    private var countriesManager : CountriesManagerProtocol!
    private var covidManager     : CovidManagerProtocol!
    private var weatherManager   : WeatherManagerProtocol!
    
    var didFinishLoading: (() -> Void)?
    var didStartLoading:  (() -> Void)?
    
    init(controller: CoordinatorDelegate, covidManager : CovidManagerProtocol)  {
        self.controller       = controller
        self.covidManager     = covidManager
    }
    
    private func showErrorMessage() {
        var actions = [AlertAction]()
        actions.append(AlertAction(title: "retryForAlert".localized(), action: { [ weak self] in
            self?.fetchData()
        }))
        actions.append(AlertAction(title: "okButtonTitle".localized(), action: { }))
        controller.coordinator?.presentAlert(title: "errorAlertTitle".localized(), message: nil, actions: actions)
        
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        self.didStartLoading?()
        
        covidManager.fetchCovidStats { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.covid = response.features.map { $0.attributes }
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



