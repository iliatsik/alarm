//
//  CoordinatorProtocol.swift
//  Lecture 44
//
//  Created by Nika Kirkitadze on 01.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var networkManager: NetworkManagerProtocol? { get }
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()

    func didTapOnCell()
    
    func goToCovidViewController()
    
    var currentCountry : String? { get }
    
    func goToSecondAlarm()
}

extension CoordinatorProtocol {
    
    var networkManager: NetworkManagerProtocol? {
        set { print("") }
        get { nil }
    }
    
    var currentCountry : String? {
        set { print("") }
        get { nil }
    }

    func start(){}
    
    func goToSecondAlarm() {}
    
}
