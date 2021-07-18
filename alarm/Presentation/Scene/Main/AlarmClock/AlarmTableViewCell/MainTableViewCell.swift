//
//  MainTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 14.06.21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let gradientLayer = CAGradientLayer()
//            gradientLayer.frame = contentView.bounds
//            gradientLayer.colors = [
//                UIColor.orange.cgColor,
//                UIColor.orange.cgColor,
//                UIColor.orange.cgColor,
//                UIColor.systemOrange.cgColor
//                ]
//        
//        contentView.layer.addSublayer(gradientLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
