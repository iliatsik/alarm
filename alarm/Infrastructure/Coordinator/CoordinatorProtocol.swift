//
//  CoordinatorProtocol.swift
//  Lecture 44
//
//  Created by Nika Kirkitadze on 01.07.21.
//

import UIKit

struct AlertAction {
   let title: String
   let action: () -> Void
}

protocol CoordinatorProtocol: AnyObject {
    
    var networkManager: NetworkManagerProtocol? { get }
    
    var navigationController: UINavigationController? { get }
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()

    func didTapOnCell()
    
    func goToCovidViewController()
    
    var filteredData : [Covid]? {get}
    
    func goToSecondAlarm()
    
    func passCountry(countryName : String)
        
    func presentAlert(title: String?, message: String?, actions: [AlertAction]) 


}

extension CoordinatorProtocol {
    
    var networkManager: NetworkManagerProtocol? {
        set { print("") }
        get { nil }
    }
    
    var filteredData: [Covid]? {
        set { print("")}
        get { nil }
    }

    func start(){ }
    
    func goToSecondAlarm() { }
    
    func passCountry(countryName : String) { }
    
    func presentAlert(title: String?, message: String?, actions: [AlertAction]) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.map { action -> UIAlertAction in
            let alertAction = UIAlertAction(title: action.title, style: .default) { _ in
                action.action()
            }
            return alertAction
        }
        .forEach { alertView.addAction($0) }
        
        navigationController?.present(alertView, animated: true, completion: nil)
    }
    
    func didTapOnCell() { }
    
    func goToCovidViewController() { }
}
