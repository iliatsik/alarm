//
//  String.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 14.12.21.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
