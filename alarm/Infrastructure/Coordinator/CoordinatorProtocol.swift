//
//  CoordinatorProtocol.swift
//  Lecture 44
//
//  Created by Nika Kirkitadze on 01.07.21.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var networkManager: NetworkManagerProtocol { get }
    
    init(_ window: UIWindow?, navigationController: UINavigationController?)
    
    func start()
//    func proceedToProductDetails(with product: Product?)
//    func proceedToBuy(with product: Product?)
    func didTapOnCell()
    
}

