//
//  CovidConfirmedTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit

class CovidConfirmedTableViewCell: UITableViewCell {

    @IBOutlet weak var labelConfirmed: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
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
    }
    
    func configure(with item: CovidViewModel) {
        textLabel?.text = "\(item.confirmed)"
    }
}
