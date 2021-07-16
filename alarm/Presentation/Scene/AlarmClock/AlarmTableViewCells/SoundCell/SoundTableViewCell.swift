//
//  SoundTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

class SoundTableViewCell: UITableViewCell {

    @IBOutlet weak var soundLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
