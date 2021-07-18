//
//  ViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 05.06.21.
//

import UIKit

class AlarmViewController: BaseViewController, SecondAlarmDelegate {
    func finishPassing(hour: String, minute: String, label: String, index: Int, songName: String) {
        passedMinute   = minute
        passedHour     = hour
        passedLabel    = label
        indexForCount  += index
        passedRingtone = songName
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondAlarmViewController {
            destination.delegate = self
        }
    }
    var indexForCount  : Int = 0
    var passedHour     : String!
    var passedMinute   : String!
    var passedLabel    : String!
    var passedRingtone : String!


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.separatorColor = UIColor.white
        
        setUpTableView()
        tableView.reloadData()
    }

    private func setUpTableView() {
         tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
         tableView.backgroundColor = UIColor.black
         tableView.delegate = self
         tableView.dataSource = self
    }
    
    @IBAction func addFButton(_ sender: Any) {
        performSegue(withIdentifier: "main_alarm_segue", sender: self)
        let sb = UIStoryboard(name: "SecondAlarmViewController", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SecondAlarmViewController")
        present(vc, animated: true)

    }
    
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexForCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.nameLabel.text = "\(passedLabel ?? "Alarm"), \(passedRingtone ?? "Default")"
        cell.timeLabel.text = "\(passedHour ?? "00"):\(passedMinute ?? "00")"
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
//           self.indexForCount.remove(at: indexPath.row)
           indexForCount -= 1
           self.tableView.beginUpdates()
           self.tableView.deleteRows(at: [indexPath], with: .automatic)
           self.tableView.endUpdates()
            
        }
    }
   
}

