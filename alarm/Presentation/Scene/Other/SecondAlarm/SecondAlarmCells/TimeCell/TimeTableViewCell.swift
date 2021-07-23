//
//  TimeTableViewCell.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit
import UserNotifications

protocol TimeDelegate {
    func finishPassingTime(hour: Int, minute: Int)
}

class TimeTableViewCell: UITableViewCell {

    var delegate : TimeDelegate!
    
    var hours   : Int = 0
    var minutes : Int = 0
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate    = self
        pickerView.dataSource  = self
        pickerView.tintColor = .systemOrange
        pickerView.layer.borderColor = UIColor.systemOrange.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}

extension TimeTableViewCell : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)" }
        case 1:
            if row < 10 {
                return "0\(row)"
            } else {
                return "\(row)" }
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hours   = row
        case 1:
            minutes = row

        default:
            break;
        }
        pickerView.tintColor = .systemOrange

        delegate.finishPassingTime(hour: hours, minute: minutes)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
       if component == 0 {
        var hourData = ""
        if row < 10 {
            hourData = "0\(row)"
        } else {
            hourData = "\(row)"
        }
           let myHourData = NSAttributedString(string: hourData, attributes: [.foregroundColor:UIColor.white])
           return myHourData
       }
       else {
        var minuteData = ""
        if row < 10 {
            minuteData = "0\(row)"
        } else {
            minuteData = "\(row)"
        }
        let myMinuteData = NSAttributedString(string: minuteData, attributes: [.foregroundColor:UIColor.white])
           return myMinuteData
       }
    }
    
}


