//
//  UITableViewCell+Extension.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    
    static var nib: UINib { UINib(nibName: identifier, bundle: Bundle.main) }
}
