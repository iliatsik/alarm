//
//  CountryTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with item: CountryViewModel) {
        timezoneLabel.text = item.time
        countryLabel.text = item.capital
        timeLabel.text = item.exactTime
    }
}
