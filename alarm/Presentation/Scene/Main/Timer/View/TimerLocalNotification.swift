//
//  LocalNotificationTimer.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 10.06.21.
//

import UIKit

extension TimerViewController {
    
    func setUpNotification(){
        center.getPendingNotificationRequests { requests in
            print(requests)
        }
        center.delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "Clock"
        content.body = "Timer"
        content.categoryIdentifier = "Alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(selectedAudio ?? "613").mp3"))

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01,
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification_id",
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
          if let error = error {
              print(error)
          }
        }

        center.add(request)
        
    }
}
    



extension TimerViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler( [.alert, .badge, .sound])
 
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
