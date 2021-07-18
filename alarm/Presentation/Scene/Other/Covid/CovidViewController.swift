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
    
    var index = 0
    private var covidList = [Covid]()
    private var active    : Int = 0
    private var recovered : Int = 0
    private var death     : Int = 0
    private var confirmed : Int = 0
    
    private var covidManager : CovidManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager = CovidManager()
        
    }

    func configureView() {
        covidManager.fetchCovidStats { [weak self] result in
            switch result {
            case .success(let cList):
                self?.covidList = cList
                self?.configure(with: (self?.covidList[self?.index ?? 0])!)
                
            case . failure(let err):
                print(err)
            }
        }
    }
    
    func configure(with item: Covid) {
        labelActive.text    = "\(item.Active ?? 0)"
        labelDeaths.text    = "\(item.Deaths ?? 0)"
        labelRecovered.text = "\(item.Recovered ?? 0)"
        labelConfirmed.text = "\(item.Confirmed ?? 0)"
    }
}
