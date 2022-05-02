//
//  SecondViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 10.06.21.
//

import UIKit
import AVFoundation

protocol SecondTimerDelegate {
    func finishPassing(string: String)
}

class SecondTimerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate: SecondTimerDelegate?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var setBarButton: UIBarButtonItem!
    var audioPlayer : AVAudioPlayer!
    var audioString : String!
    
    var arrayOfRingtones = [
        "Auratone",
        "Happyday",
        "Ping1",
        "Ping2",
        "Softchime",
        "Daybreak",
        "EarlyRiser",
        "SlowMorning",
        "Saying",
        "613",
        "Inflicted",
        "Pristine"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "addRingtoneLabel".localized()
        cancelBarButton.title = "cancelNavigationBar".localized()
        setBarButton.title = "setNavigationBar".localized()
        tableView.delegate                            = self
        tableView.dataSource                          = self
        tableView.separatorColor                      = .white
        tableView.sectionIndexTrackingBackgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfRingtones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none

        cell.textLabel?.text      = arrayOfRingtones[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.tintColor            = .systemOrange
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        let pathToSound = Bundle.main.path(forResource: arrayOfRingtones[indexPath.row], ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        delegate?.finishPassing(string: arrayOfRingtones[indexPath.row])
        audioPlayer.play()
        } 
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
   
    @IBAction func setRingtone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelRingtone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
