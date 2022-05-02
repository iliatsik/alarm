//
//  TimerExtension.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 06.06.21.
//

import UIKit
import UserNotifications
import AVFoundation

extension TimerViewController {
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerLabel.text = timeLeft.time
        }
        
        if timeLeft.time == "00:00" {
            setUpNotification()

            startAndPauseButton.backgroundColor = UIColor(named: "start")
            startAndPauseButton.setTitleColor(.green, for: .normal)
            startAndPauseButton.setTitle("startButton".localized(), for: .normal)
            startView.layer.borderColor = UIColor(named: "start")?.cgColor
            
            timerLabel.isHidden         = true
            timeLeftShapeLayer.isHidden = true
            bgShapeLayer.isHidden       = true
            pickerV.isHidden            = false
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            timer.invalidate()
        }
    }
    
    
    func setUpShapeLayer() {
            drawBgShape()
            drawTimeLeftShape()
            strokeIt.fromValue = 1
            strokeIt.toValue   = 0
            strokeIt.duration  = timeLeft
            timeLeftShapeLayer.add(strokeIt, forKey: nil)
            endTime = Date().addingTimeInterval(timeLeft)
            timer   = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func drawBgShape() {
        guard let radius = radius else {return}
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: timerLabel.frame.midX ,
                                                            y: timerLabel.frame.midY),
                                         radius: radius,
                                         startAngle: -90.degreesToRadians,
                                         endAngle: 270.degreesToRadians, clockwise: true).cgPath
        
        bgShapeLayer.strokeColor = UIColor.darkGray.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 9
        view.layer.addSublayer(bgShapeLayer)
    }
    
    
    func drawTimeLeftShape() {
        guard let radius = radius else {return}
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: timerLabel.frame.midX ,
                                                                  y: timerLabel.frame.midY),
                                               radius: radius,
                                               
                                               
                                               startAngle: -90.degreesToRadians,
                                               endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.systemOrange.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 7
        view.layer.addSublayer(timeLeftShapeLayer)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            radius = timerLabel.frame.size.width / 2
        case .landscapeLeft, .landscapeRight:
            radius = timerLabel.frame.size.width / 3.5
        default:
            radius = timerLabel.frame.size.width / 3.5
        }
    }
}



extension TimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {

         func numberOfComponents(in pickerView: UIPickerView) -> Int {
             return 3
         }

         func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
             switch component {
             case 0:
                 return 24
             case 1, 2:
                 return 60
             default:
                 return 0
             }
         }

         func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
             return pickerView.frame.size.width/3
         }

         func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             switch component {
             case 0:
                 return "\(row)" + "hoursInPickerView".localized()
             case 1:
                 return "\(row)" + "minutesInPickerView".localized()
             case 2:
                 return "\(row)" + "secondsInPickerView".localized()
             default:
                 return ""
             }
         }
         func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
             switch component {
             case 0:
                 hour    = row
             case 1:
                 minutes = row
             case 2:
                 seconds = row
             default:
                 break;
             }
         }
         func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            if component == 0 {
                let hourData = "\(row) "+"hoursInPickerView".localized()
                let myHourData = NSAttributedString(string: hourData, attributes: [.foregroundColor:UIColor.white])
                return myHourData
            }
            else if component == 1{
                let minuteData = "\(row) "+"minutesInPickerView".localized()
                let myMinuteData = NSAttributedString(string: minuteData, attributes: [.foregroundColor:UIColor.white])
                return myMinuteData
            }
            else {
                let secondData = "\(row) "+"secondsInPickerView".localized()
                let mySecondData = NSAttributedString(string: secondData, attributes: [.foregroundColor:UIColor.white])
                return mySecondData
           }
         }
    
         func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
                return 30.0
         }
}




