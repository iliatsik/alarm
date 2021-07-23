//
//  RepeatTableViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

protocol RepeatDelegate {
    func finishPassingRepeat(string: String)
}

class RepeatTableViewController: UIViewController {

    var repeatDays  = [Int: String]()
    let weekday = [ "Weekdays",  "Weekends", "Everyday"]
    
    var delegate : RepeatDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.backgroundColor = .darkGray
        tableView.sectionIndexBackgroundColor = .darkGray
        tableView.separatorColor = .white
        tableView.sectionIndexTrackingBackgroundColor = .white
    }
    

    @IBAction func backAndSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension RepeatTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repeat_cell", for: indexPath)
        cell.textLabel?.text = "\(weekday[indexPath.row])"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.tintColor = .systemOrange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.finishPassingRepeat(string: weekday[indexPath.row])

        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }

}
