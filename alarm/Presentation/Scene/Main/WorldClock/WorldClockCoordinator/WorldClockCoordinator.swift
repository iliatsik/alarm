//
//  WorldClockCoordinator.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//


import UIKit

final class WorldClockCoordinator: CoordinatorProtocol {

    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    var currentCountry : String?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .black

        let vc = WorldClockViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "worldclock")
        vc.tabBarItem.title = "worldClockTitle".localized()
        self.navigationController?.viewControllers = [vc]
    }
    
    func didTapOnCell() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "covidStatisticActionSheetTitle".localized(), style: .default, handler: { [weak self] action in
            let sb = UIStoryboard(name: "CovidViewController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CovidViewController") as! CovidViewController
            vc.coordinator = self
            vc.currentCountry = self?.currentCountry
            
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.navigationBar.tintColor = .systemOrange
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "weatherStatisticActionSheetTitle".localized(),  style: .default, handler: { [weak self] action in
            let sb = UIStoryboard(name: "WeatherViewController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
            vc.coordinator = self
            vc.currentCountry = self?.currentCountry
            
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.navigationBar.tintColor = .systemOrange
            self?.navigationController?.pushViewController(vc, animated: true)
        }))

        alert.addAction(UIAlertAction(title: "cancelForAlert".localized(), style: .cancel, handler: { action in
        }))
        
        self.navigationController?.present(alert, animated: true)
    }
    
    func passCountry(countryName: String) {
           currentCountry = countryName
    }
    
}

