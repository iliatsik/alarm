//
//  SoundTableViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit
import AVFoundation

protocol SoundDelegate {
    func finishPassingSound(string: String)
}

class SoundTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : SoundDelegate!
    
   
    
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
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.backgroundColor = .darkGray
        tableView.sectionIndexBackgroundColor = .darkGray
        tableView.separatorColor = .white
        tableView.sectionIndexTrackingBackgroundColor = .white
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfRingtones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sound_cell", for: indexPath)
        cell.textLabel?.text = arrayOfRingtones[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        cell.tintColor = .systemOrange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
//        tableView.sectionIndexColor = .darkGray
        let pathToSound = Bundle.main.path(forResource: arrayOfRingtones[indexPath.row], ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do{
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        self.audioString = arrayOfRingtones[indexPath.row]
        audioPlayer.play()
            
        } catch{}
        
        delegate?.finishPassingSound(string: arrayOfRingtones[indexPath.row])
    }

    func getMyRingtone(ringtone: String) -> String {
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
        
    @IBAction func backAndSave(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
