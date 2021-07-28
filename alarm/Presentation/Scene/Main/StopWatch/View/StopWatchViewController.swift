//
//  StopWatchViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 05.06.21.
//

import UIKit

class StopWatchViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var labelForCell = "00:00,0"
    var arrayOfTimer = [String]()
    
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0.0
    var resetPos = Timer()
    
    @IBOutlet weak var lapView: UIView!
    @IBOutlet weak var startView: UIView!
    override func viewDidLoad() {
        lapView.layer.cornerRadius = 40
        lapView.layer.masksToBounds = true
        lapView.layer.borderWidth = 1.5
        lapView.layer.borderColor = UIColor.darkGray.cgColor
        
        startView.layer.cornerRadius = 40
        startView.layer.masksToBounds = true
        startView.layer.borderWidth = 1.8
        startView.layer.borderColor = UIColor(named: "start")?.cgColor

        super.viewDidLoad()
        self.tableView.reloadData()
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.isEditing = !tableView.isEditing
        self.tableView.backgroundColor  = UIColor.black
        
        lapButton.layer.cornerRadius    = 35
        startButton.layer.cornerRadius  = 35
        startButton.layer.masksToBounds = true
        lapButton.layer.masksToBounds   = true
 
        lapButton.layer.borderWidth     = 1
        lapButton.layer.borderColor     = UIColor.black.cgColor
        
        startButton.layer.borderWidth   = 1
        startButton.layer.borderColor   = UIColor.black.cgColor
        
        startButton.isEnabled = true
        //pause is false
        lapButton.isEnabled   = false

    }
    
    @IBAction func startFunc(_ sender: Any) {
        if !timer.isValid {     //!isTimerRunning
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimer), userInfo: nil, repeats: true)
            
            startButton.backgroundColor = UIColor(named: "stop")
            startButton.setTitleColor(.red, for: .normal)
            startButton.setTitle("Stop", for: .normal)
            lapButton.setTitle("Lap", for: .normal)
            startView.layer.borderColor = UIColor(named: "stop")?.cgColor

            
            isTimerRunning      = true
            lapButton.isEnabled = true
          //pause is true
          //startButton.isEnabled = false
        } else {
            startButton.backgroundColor = UIColor(named: "start")
            startButton.setTitleColor(.green, for: .normal)
            startButton.setTitle("Start", for: .normal)
            lapButton.setTitle("Reset", for: .normal)
            startView.layer.borderColor = UIColor(named: "start")?.cgColor
            
            lapButton.isEnabled   = true
            startButton.isEnabled = true
            isTimerRunning        = false
            timer.invalidate()
        }
    }
    
    @IBAction func lapFunc(_ sender: Any) {        
        if !timer.isValid {
            timer.invalidate()
            counter = 0.0
            timerLabel.text = "00:00,0"
            isTimerRunning = false
            lapButton.isEnabled   = false
            startButton.isEnabled = true
            arrayOfTimer.removeAll()
        } else {
            arrayOfTimer.append(timerLabel.text!)
            print(arrayOfTimer)
        }
        tableView.reloadData()
    }

    @objc func runTimer() {
        counter += 0.1
        let flooredCounter = Int(floor(counter))

        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if minute < 10 {
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if second < 10 {
            secondString = "0\(second)"
        }

        let decisecond = String(format: "%.1f", counter).components(separatedBy: ".").last!
        timerLabel.text = "\(minuteString):\(secondString),\(decisecond)"
    }
    
}


extension StopWatchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTimer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StopwatchTableViewCell
        cell.backgroundColor = UIColor.black
        cell.timeLabel.text = arrayOfTimer[indexPath.row]
        cell.lapLabel.text  = "Lap: \(indexPath.row + 1)"
        
        if arrayOfTimer[indexPath.row] == arrayOfTimer.max() {
            cell.timeLabel.textColor = .red
        }

        else if arrayOfTimer[indexPath.row] == arrayOfTimer.min() {
            cell.timeLabel.textColor = .green
        }

        else {
            cell.timeLabel.textColor = .white
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
