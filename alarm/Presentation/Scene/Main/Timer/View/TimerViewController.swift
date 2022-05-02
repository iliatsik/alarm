//
//  TimerViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 05.06.21.
//

import UIKit
import UserNotifications

class TimerViewController: BaseViewController, SecondTimerDelegate {
    func finishPassing(string: String) {
        selectedAudio = string
    }
    
    var radius : CGFloat?
    
    @IBOutlet weak var cancelView            : UIView!
    @IBOutlet weak var startView             : UIView!
    @IBOutlet weak var ringtoneRegisterLabel : UIButton!
    
    var registerRingtoneLabel : String!
    
    @IBOutlet weak var timerLabel          : UILabel!
    @IBOutlet weak var startAndPauseButton : UIButton!
    @IBOutlet weak var cancelButton        : UIButton!
    @IBOutlet weak var pickerV             : UIPickerView!
    
    var selectedAudio : String!
    
    let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .none, timeStyle: .short)

    let timeLeftShapeLayer     = CAShapeLayer()
    let bgShapeLayer           = CAShapeLayer()
    var timeLeft: TimeInterval = 0.1
    var endTime: Date?

    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    
    var hour     : Int = 0
    var minutes  : Int = 0
    var seconds  : Int = 0
    
    var timer          = Timer()
    var isTimerRunning = false
    var counter        = 0.0

    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.setTitle("cancelButton".localized(), for: .normal)
        startAndPauseButton.setTitle("startButton".localized(), for: .normal)
        ringtoneRegisterLabel.layer.cornerRadius = 8
        ringtoneRegisterLabel.setTitle("whenTimerEndsButton".localized(), for: .normal)
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
        cancelView.layer.cornerRadius  = 40
        cancelView.layer.masksToBounds = true
        cancelView.layer.borderWidth   = 1.5
        cancelView.layer.borderColor   = UIColor.darkGray.cgColor
        
        startView.layer.cornerRadius   = 40
        startView.layer.masksToBounds  = true
        startView.layer.borderWidth    = 1.8
        startView.layer.borderColor    = UIColor(named: "start")?.cgColor
        
        
        UNUserNotificationCenter.current().delegate = self
        
        timeLeftShapeLayer.isHidden = true
        bgShapeLayer.isHidden       = true
        
        pickerV.delegate    = self
        pickerV.dataSource  = self
        
        timerLabel.isHidden = true
        
        cancelButton.layer.cornerRadius         = 35
        startAndPauseButton.layer.cornerRadius  = 35
        startAndPauseButton.layer.masksToBounds = true
        cancelButton.layer.masksToBounds        = true
        
        cancelButton.layer.borderWidth          = 1
        cancelButton.layer.borderColor          = UIColor.black.cgColor
        
        startAndPauseButton.layer.borderWidth   = 1
        startAndPauseButton.layer.borderColor   = UIColor.black.cgColor
          
        radius = timerLabel.frame.size.width / 2

    }

    
    @IBAction func startAndPauseButton(_ sender: Any) {
        timeLeftShapeLayer.isHidden = false
        bgShapeLayer.isHidden       = false
        pickerV.isHidden            = true
        timerLabel.isHidden         = false
        
        if !isTimerRunning { 
            timeLeft =  TimeInterval(Int((hour * 3600) + (minutes * 60) + seconds))
            setUpShapeLayer()
                        
            
            timerLabel.isHidden    = false
            startAndPauseButton.backgroundColor = UIColor(named: "pause")
            startAndPauseButton.setTitleColor(.orange, for: .normal)
            startAndPauseButton.setTitle("pauseButton".localized(), for: .normal)
            startView.layer.borderColor = UIColor(named: "pause")?.cgColor

            cancelButton.isEnabled = true
            
            timeLeftShapeLayer.resumeAnimation()
            isTimerRunning         = true
           
        } else {
            startAndPauseButton.backgroundColor = UIColor(named: "start")
            startAndPauseButton.setTitleColor(.green, for: .normal)
            startAndPauseButton.setTitle("resumeButton".localized(), for: .normal)
            startView.layer.borderColor = UIColor(named: "start")?.cgColor

            
            timeLeftShapeLayer.pauseAnimation()
            
            cancelButton.isEnabled        = true
            startAndPauseButton.isEnabled = true
            timer.invalidate()
            isTimerRunning                = false
        }

    }
    
    @IBAction func cancelButton(_ sender: Any) {
            timer.invalidate()
            
            timeLeftShapeLayer.isHidden   = true
            bgShapeLayer.isHidden         = true
            
            timeLeft                      = 0
            isTimerRunning                = false
            cancelButton.isEnabled        = false
            startAndPauseButton.isEnabled = true
            
            startAndPauseButton.backgroundColor = UIColor(named: "start")
            startAndPauseButton.setTitleColor(.green, for: .normal)
        startAndPauseButton.setTitle("startButton".localized(), for: .normal)
            
            startView.layer.borderColor = UIColor(named: "start")?.cgColor

            cancelButton.isEnabled = false
            pickerV.isHidden       = false
            timerLabel.isHidden    = true
    }

    
   
    @IBAction func ringtoneButton(_ sender: Any) {
        performSegue(withIdentifier: "name", sender: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondTimerViewController {
            destination.delegate = self
        }
    }
    
}





