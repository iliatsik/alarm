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
    private(set) var navigationController: UINavigationController?
    
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
        navigationController?.setNavigationBarHidden(true, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}



