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
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
        if let destination = segue.destination as? LabelTableViewController {
            destination.delegate = self
        }
        
        if let destination = segue.destination as? SoundTableViewController{
            destination.delegate = self
        }
        if let destination = segue.destination as? RepeatTableViewController{
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
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "repeat", for: indexPath) as! RepeatTableViewCell
            cell.repeatLabel.text = "\(passedRepeatString ?? "Once") >"
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "label", for: indexPath) as! LabelTableViewCell
            cell.alarmLabel.text = "\(passedLabelString ?? "Alarm") >"
            cell.alarmLabel.textColor = .lightGray
            return cell
        }
        
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sound", for: indexPath) as! SoundTableViewCell
            cell.soundLabel.text = "\(passedSoundString ?? "613") >"
            return cell
        }
        
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "snooze", for: indexPath) as! SnoozeTableViewCell
            if (cell.vibrationSwitch.isOn == true) {
                vibrate = true
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 1 {
            performSegue(withIdentifier: "repeat_segue", sender: nil)
        }
        if indexPath.row == 2 {
            performSegue(withIdentifier: "label_segue", sender: nil)
        }
        if indexPath.row == 3 {
            performSegue(withIdentifier: "sound_segue", sender: nil)
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
        content.title = "Alarm"
        content.body = "Notification"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(passedSoundString ?? "613").mp3"))
        content.categoryIdentifier = "Alarm"
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
//func removePendingNotificationRequests(withIdentifiers identifiers: [String]) to stop receive nots

extension SecondAlarmViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler( [.alert, .badge, .sound])
 
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
