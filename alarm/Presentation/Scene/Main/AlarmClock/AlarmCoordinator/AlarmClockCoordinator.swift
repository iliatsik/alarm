//
//  AlarmClockCoordinator.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import UIKit


final class AlarmClockCoordinator: CoordinatorProtocol {
    func passIndexAndCountry(with index: Int, and country: String) { }
    func goToCovidViewController() { }
    
    func didTapOnCell() { }
    var networkManager: NetworkManagerProtocol?
    var navigationController: UINavigationController?
    
    init(_ window: UIWindow? = nil, navigationController: UINavigationController? = UINavigationController()) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        
        let vc = AlarmViewController.instantiateFromStoryboard()
        vc.coordinator = self
        vc.tabBarItem.image = UIImage(named: "alarmclock")
        vc.title = "Alarm"
        
        self.navigationController?.viewControllers = [vc]
        
    }
    
    func goToSecondAlarm(){
        let sb = UIStoryboard(name: "SecondAlarmViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SecondAlarmViewController")
        self.navigationController?.present(vc, animated: true)
    }
}
