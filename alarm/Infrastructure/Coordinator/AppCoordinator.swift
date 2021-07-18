//
//  Coordinator.swift
//  Lecture 44
//
//  Created by Nika Kirkitadze on 01.07.21.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {

    // MARK: - Private properties
    
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Internal properties
    
    
    required init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
        self.networkManager = NetworkManager()
    }
    
    func start() {        
        let vc = MainTabBarViewController.instantiateFromStoryboard()

        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: true)

        navigationController?.isNavigationBarHidden = true 
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    

    func didTapOnCell() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Weather",  style: .default, handler: { [weak self] action in
            // go to weather vc
        }))
        
        alert.addAction(UIAlertAction(title: "Covid Stats", style: .default, handler: { [weak self] action in
            self?.goToCovidViewController()
        }))
        self.navigationController?.present(alert, animated: true)
    }

    func goToCovidViewController() {
        let sb = UIStoryboard(name: "CovidViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CovidViewController") as! CovidViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passIndexAndCountry(with index : Int, and country: String){
        let index = index
        let country = country
    }
}



