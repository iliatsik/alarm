//
//  RepeatTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

class RepeatTableViewCell: UITableViewCell {

    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var repeatOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.3,
                           options: [],
                           animations: { [weak self] in
                            self?.contentView.alpha = 0.1
                           }, completion: nil)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.1,
                           options: [],
                           animations: { [weak self] in
                            self?.contentView.alpha = 1
                           }, completion: nil)
        }
        // Configure the view for the selected state
    }

}
