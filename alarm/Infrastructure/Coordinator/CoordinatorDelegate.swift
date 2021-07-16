//
//  CoordinatorDelegate.swift
//  Lecture 44
//
//  Created by Nika Kirkitadze on 01.07.21.
//

import UIKit

protocol CoordinatorDelegate: UIViewController {
    var coordinator: CoordinatorProtocol? { get set }
}
