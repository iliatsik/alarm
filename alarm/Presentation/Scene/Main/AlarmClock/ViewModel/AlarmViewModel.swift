//
//  AlarmViewModel.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 19.07.21.
//

import UIKit

protocol AlarmViewModelProtocol: AnyObject {
    
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
}

final class AlarmViewModel: AlarmViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
}
