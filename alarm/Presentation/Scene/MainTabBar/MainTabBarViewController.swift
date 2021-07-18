//
//  MainTabBarViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 16.07.21.
//

import UIKit

class MainTabBarViewController: UITabBarController, Storyboarded, CoordinatorDelegate {

    private var worldclockCoordinator = WorldClockCoordinator()
    private var alarmCoordinator      = AlarmClockCoordinator()
    private var stopwatchCoordinator  = StopWatchCoordinator()
    private var timerCoordinator      = TimerCoordinator()

    var coordinator: CoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .systemOrange
        tabBar.unselectedItemTintColor = .lightGray
        viewControllers = [
            worldclockCoordinator.navigationController!,
            alarmCoordinator.navigationController!,
            stopwatchCoordinator.navigationController!,
            timerCoordinator.navigationController!
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.barTintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .systemOrange
    }
    

}
