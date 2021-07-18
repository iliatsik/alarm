//
//  TimerCoordinator.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import UIKit

final class TimerCoordinator: CoordinatorProtocol {

    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        
        let vc = TimerViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "timer")
        vc.title = "Timer"

        self.navigationController?.viewControllers = [vc]
        
    }
    
}
