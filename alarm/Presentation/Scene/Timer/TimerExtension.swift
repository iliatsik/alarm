//
//  TimerExtension.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 06.06.21.
//

import UIKit
import UserNotifications

extension TimerViewController {
    
    @objc func updateTime() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timerLabel.text = timeLeft.time
        }else {
            timerLabel.text = "00:00"
            timer.invalidate()
        }
        
        if timeLeft.time == "00:00" {
            setUpNotification()

            startAndPauseButton.backgroundColor = UIColor(named: "start")
            startAndPauseButton.setTitleColor(.green, for: .normal)
            startAndPauseButton.setTitle("Start", for: .normal)
            startView.layer.borderColor = UIColor(named: "start")?.cgColor
            
            timerLabel.isHidden         = true
            timeLeftShapeLayer.isHidden = true
            bgShapeLayer.isHidden       = true
            pickerV.isHidden            = false
            timeAndRingStack.isHidden   = true
            timer.invalidate()
        }
    }
    
    
    func setUpShapeLayer() {
            drawBgShape()
            drawTimeLeftShape()
            //define the fromValue, toValue and duration of your animation
            strokeIt.fromValue = 1
            strokeIt.toValue   = 0
            strokeIt.duration  = timeLeft
            // add the animation to your timeLeftShapeLayer
            timeLeftShapeLayer.add(strokeIt, forKey: nil)
            // define the future end time by adding the timeLeft to now Date()
            endTime = Date().addingTimeInterval(timeLeft)
            timer   = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 200 ), radius:
            190, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.darkGray.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 9
        view.layer.addSublayer(bgShapeLayer)
    }
    
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY - 200), radius:
            190, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.systemOrange.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 7
        view.layer.addSublayer(timeLeftShapeLayer)
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
                 return "\(row) Hour"
             case 1:
                 return "\(row) Minute"
             case 2:
                 return "\(row) Second"
             default:
                 return ""
             }
         }
         func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
             switch component {
             case 0:
                 hour = row
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
                let hourData = "\(row) hours"
                let myHourData = NSAttributedString(string: hourData, attributes: [.foregroundColor:UIColor.white])
                return myHourData
            }
            else if component == 1{
                let minuteData = "\(row) min"
                let myMinuteData = NSAttributedString(string: minuteData, attributes: [.foregroundColor:UIColor.white])
                return myMinuteData
            }
            else {
                let secondData = "\(row) sec"
                let mySecondData = NSAttributedString(string: secondData, attributes: [.foregroundColor:UIColor.white])
                return mySecondData
           }
         }
    
         func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
                return 30.0
         }
}

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}


extension CALayer
{
    func pauseAnimation() {
        if isPaused() == false {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }

    func resumeAnimation() {
        if isPaused() {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }

    func isPaused() -> Bool {
        return speed == 0
    }
}
