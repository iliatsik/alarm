//
//  RepeatTableViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

class RepeatTableViewController: UIViewController {

    var repeatDays  = [Int: String]()
    let weekday = [ "Weekdays",  "Weekends", "Everyday"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate   = self
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(weekday[indexPath.row])"
        cell.textLabel?.textColor = .white
        cell.tintColor = .systemOrange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }

}
