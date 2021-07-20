//
//  CovidViewController.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 18.07.21.
//

import UIKit

class CovidViewController: BaseViewController {

    @IBOutlet weak var labelActive    : UILabel!
    @IBOutlet weak var labelRecovered : UILabel!
    @IBOutlet weak var labelDeaths    : UILabel!
    @IBOutlet weak var labelConfirmed : UILabel!
        
    private var covidList = [Covid]()
    private var covidManager : CovidManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager = CovidManager()
//        configureView()
    }

//    func configureView() {
//        covidManager.fetchCovidStats { [weak self] result in
//            switch result {
//            case .success(let cList):
//
//                self?.covidList = cList
////                self?.configure(with: (self?.covidList[0])!)
//
//
//            case .failure(let err):
//                print(err)
//            }
//          
//        }
//    }
    
    func configure(with item: CovidViewModel) {
        DispatchQueue.main.async {
            self.labelActive.text    = "Active: \(item.active)"
            self.labelDeaths.text    = "Death: \(item.death)"
            self.labelRecovered.text = "Recovored: \(item.recovered )"
            self.labelConfirmed.text = "Confirmed: \(item.confirmed)"
        }
    }
}
