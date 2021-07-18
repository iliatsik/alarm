//
//  WorldClockCoordinator.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//


import UIKit

final class WorldClockCoordinator: CoordinatorProtocol {
    
    var coordinator: CoordinatorProtocol?
    
    func passIndexAndCountry(with index: Int, and country: String) { }
    func goToCovidViewController() { }

    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        
        let vc = WorldClockViewController.instantiateFromStoryboard()
        vc.coordinator = self
        
        vc.tabBarItem.image = UIImage(named: "worldclock")
        vc.title = "World Clock"
        
        self.navigationController?.viewControllers = [vc]
    }
    
    func didTapOnCell() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Weather",  style: .default, handler: { [weak self] action in
        }))
        
        alert.addAction(UIAlertAction(title: "Covid Stats", style: .default, handler: { [weak self] action in
            let sb = UIStoryboard(name: "CovidViewController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CovidViewController") as! CovidViewController
            self?.navigationController?.navigationBar.backgroundColor = .darkGray
            self?.navigationController?.navigationBar.tintColor = .lightGray
            self?.navigationController?.navigationBar.barTintColor = .black
            
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }))
        self.navigationController?.present(alert, animated: true)
    }
}
