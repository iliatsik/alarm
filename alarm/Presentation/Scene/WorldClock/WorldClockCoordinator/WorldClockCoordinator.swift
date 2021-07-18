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
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        
        let vc = WorldClockViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "worldclock")
        vc.title = "World Clock"
        
        self.navigationController?.viewControllers = [vc]
        
    }
    
}
