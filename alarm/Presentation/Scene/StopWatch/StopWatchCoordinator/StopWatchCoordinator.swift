//
//  StopWatchCoordinator.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import UIKit

final class StopWatchCoordinator: CoordinatorProtocol {

    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        
        let vc = StopWatchViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "stopwatch")
        vc.title = "Stopwatch"
        
        self.navigationController?.viewControllers = [vc]
        
    }
    
}
