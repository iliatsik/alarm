//
//  NavigationBar.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 10.06.21.
//

import UIKit
class NavigationBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private func setupLayout() {
        backgroundColor = .gray
        layer.cornerRadius = 8
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
