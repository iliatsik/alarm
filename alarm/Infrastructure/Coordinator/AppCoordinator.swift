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
    var navigationController: UINavigationController?
    
    // MARK: - Internal properties
    
    var networkManager: NetworkManagerProtocol?
    
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
        self.networkManager = NetworkManager()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
//        let sb = UIStoryboard(name: "ProductsViewController", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        
        let vc = TabBarViewController.instantiateFromStoryboard()

        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
//    func proceedToProductDetails(with product: Product?) {
////        let sb = UIStoryboard(name: "ProductDetailsViewController", bundle: nil)
////        let vc = sb.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
//
//        let vc = ProductDetailsViewController.instantiateFromStoryboard()
//        vc.product = product
//        vc.coordinator = self
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func proceedToBuy(with product: Product?) {
////        let sb = UIStoryboard(name: "BuyViewController", bundle: nil)
////        let vc = sb.instantiateViewController(withIdentifier: "BuyViewController") as! BuyViewController
//
//        let vc = BuyViewController.instantiateFromStoryboard()
//        vc.product = product
//        vc.coordinator = self
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
    func didTapOnCell() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Weather",  style: .default, handler: { [weak self] action in
            // go to main vc
        }))
        
        alert.addAction(UIAlertAction(title: "Covid Stats", style: .default, handler: { [weak self] action in
            // go to main vc
        }))
        self.navigationController?.present(alert, animated: true)
    }

}



