//
//  WeatherViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 21.07.21.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "cloudy")
        tableView.backgroundColor = .clear
        tableView.separatorColor  = .white
        tableView.tintColor       = .white
    }
    
}
