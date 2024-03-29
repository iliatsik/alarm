//
//  SecondAlarmViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 08.06.21.
//

import UIKit
import UserNotifications
import AVFoundation

protocol SecondAlarmDelegate {
    func finishPassing(hour: String, minute: String, label: String, index: Int, songName: String )
}

class SecondAlarmViewController: UIViewController, LabelDelegate, SoundDelegate, TimeDelegate, RepeatDelegate {
    func finishPassingRepeat(string: String) {
        passedRepeatString = string
        tableView.reloadData()
    }
    func finishPassingTime(hour: Int, minute: Int) {
        hours   = hour
        minutes = minute
        
        if hour < 10 && minute < 10 {
            minutesInString = "0\(minute)"
            hoursInString   = "0\(hour)"
        }
        else if hour < 10 && minute >= 10{
            minutesInString = "\(minute)"
            hoursInString   = "0\(hour)"
        }
        else if hour >= 10 && minute < 10{
            minutesInString = "0\(minute)"
            hoursInString   = "\(hour)"
        }
        else {
        minutesInString = "\(minute)"
        hoursInString   = "\(hour)"
        }
    }
 
    func finishPassingSound(string: String) {
        passedSoundString = string
        tableView.reloadData()
    }
    
    func finishPassing(string: String) {
        passedLabelString = string
        tableView.reloadData()
    }
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    var delegate: SecondAlarmDelegate?
    
    let center = UNUserNotificationCenter.current()
    
    var passedLabelString  : String!
    var passedSoundString  : String!
    var passedRepeatString : String!
    
    var audioStr : String!
    var soundTableCell : SoundTableViewCell!
    
    @IBOutlet weak var tableView: UITableView!
    
    var hours    : Int  = 0
    var minutes  : Int  = 0
    var seconds  : Int  = 0
    var index    : Int  = 0
    var vibrate  : Bool = false
    
    var hoursInString : String!
    var minutesInString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        title = "addAlarmLabel".localized()
        saveBarButton.title = "saveNavigationBar".localized()
        cancelBarButton.title = "cancelNavigationBar".localized()
        UNUserNotificationCenter.current().delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "dark")
    }
   
    @IBAction func saveData(_ sender: Any) {
        index += 1
        delegate?.finishPassing(hour: (hoursInString ?? "00"), minute: (minutesInString ?? "00"), label: (passedLabelString ?? "Alarm"), index: index, songName: (passedSoundString ?? "Default"))
        setUpAlarm()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelData(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LabelViewController {
            destination.delegate = self
        }
        if let destination = segue.destination as? SoundViewController{
            destination.delegate = self
        }
        if let destination = segue.destination as? RepeatViewController{
            destination.delegate = self
        }
    }
}

extension SecondAlarmViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "time", for: indexPath) as! TimeTableViewCell
            cell.delegate = self
            cell.timeOutlet.text = "timeLabel".localized()
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "repeat", for: indexPath) as! RepeatTableViewCell
            cell.repeatLabel.text = "\(passedRepeatString ?? "onceLabel".localized()) >"
            cell.repeatOutlet.text = "repeatLabel".localized()
            cell.selectionStyle = .none
            cell.backgroundColor = .gray
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelTableViewCell
            cell.alarmLabel.text = "\(passedLabelString ?? "alarmLabel".localized()) >"
            cell.labelOutlet.text = "textLabel".localized()
            cell.selectionStyle = .none
            cell.backgroundColor = .gray
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sound", for: indexPath) as! SoundTableViewCell
            cell.soundLabel.text = "\(passedSoundString ?? "613") >"
            cell.soundOutlet.text = "soundLabel".localized()
            cell.selectionStyle = .none
            cell.backgroundColor = .gray
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "snooze", for: indexPath) as! SnoozeTableViewCell
            if (cell.vibrationSwitch.isOn == true) {
                vibrate = true
            }
            cell.snoozeOutlet.text = "snoozeLabel".localized()
            cell.selectionStyle = .none
            cell.backgroundColor = .gray
            return cell
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 111.0
        } else {
            return 50.0
        }
    }
    

    
}

extension SecondAlarmViewController {
    func setUpAlarm() {
        
        center.getPendingNotificationRequests { requests in
            print(requests)
        }
        center.delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "alarmForNotification".localized()
        content.body = "notifForNotification".localized()
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(passedSoundString ?? "613").mp3"))
        content.categoryIdentifier = "alarmForNotification".localized()
        content.userInfo = ["customData": "fizzbuzz"]
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        var dateComponents       = DateComponents()

        dateComponents.calendar  = calendar
        dateComponents.hour      = hours
        dateComponents.minute    = minutes
        

        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString ,
                    content: content, trigger: trigger)

        if vibrate == true {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        
        UNUserNotificationCenter.current().add(request) { error in
          if let error = error {
              print(error)
          }
        }
        center.add(request)

    }
}


extension SecondAlarmViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler( [.banner, .badge, .sound, .list])
 
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
