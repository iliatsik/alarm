//
//  CovidDataSource.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 23.07.21.
//

import UIKit

class CovidDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var tableView: UITableView!
    private var viewModel: CovidListViewModelProtocol!
    private var covidList = [Covid]()
        
    var filteredData   = [Covid]()
    var currentCountry : String?
    
    init(with tableView: UITableView, viewModel: CovidListViewModelProtocol, countryName : String) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.viewModel      = viewModel
        self.currentCountry = countryName
    }
    
    func refresh() {
        let covid = viewModel.covid
        filteredData = covid.filter { $0.countryRegion == self.currentCountry }
        covidList = filteredData
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.deque(ChartTableViewCell.self, for: indexPath)
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none
            cell.arrayOfData += covidList.map { $0.confirmed ?? 0 }
            cell.arrayOfData += covidList.map { $0.active ?? 0 }
            cell.arrayOfData += covidList.map { $0.death ?? 0 }
            cell.arrayOfData += covidList.map { $0.recovered ?? 0 }
            
            return cell
            
        }
        
        if indexPath.row == 1 {
            let cell = tableView.deque(CovidConfirmedTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.confirmed ?? 0 } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
            cell.labelConfirmed.text = "confirmedLabel".localized()
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.selectionStyle = .none
            cell.alpha = 0.0

            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.deque(ActiveTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.active ?? 0 } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
            cell.labelActive.text = "activeLabel".localized()
            
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(DeathTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.death ?? 0 } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
            cell.labelDeath.text = "deathLabel".localized()
            
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.deque(RecoveredTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.recovered ?? 0 } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
            cell.labelRecovered.text = "recoveredLabel".localized()
            
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.deque(IncidentTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.incidentRate ?? 0 } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
            cell.labelIncident.text = "incidentRateLabel".localized()
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        else {
            let cell = tableView.deque(MortalityTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.mortalityRate ?? 0 } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
            cell.labelMortality.text = "mortalityRateLabel".localized()
         
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 400}
        else                  { return 80 }
    }
}



extension CovidDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
