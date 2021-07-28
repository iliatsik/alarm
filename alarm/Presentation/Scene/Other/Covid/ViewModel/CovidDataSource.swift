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
    
    private var covidList = [CovidViewModel]()
    
    var coordinator    : CoordinatorProtocol?
    
    var filteredData   = [CovidViewModel]()
    
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
        
        viewModel.getCovidData { [weak self] result in
            self?.filteredData = result.filter { $0.name == self?.currentCountry }
            
            self?.covidList = (self?.filteredData)!

            print(self?.filteredData ?? "")
            self?.tableView.reloadData()
        }
        
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
            cell.arrayOfData += covidList.map { $0.confirmed }
            cell.arrayOfData += covidList.map { $0.active }
            cell.arrayOfData += covidList.map { $0.death }
            cell.arrayOfData += covidList.map { $0.recovered }
            
            return cell
            
        }
        
        if indexPath.row == 1 {
            let cell = tableView.deque(CovidConfirmedTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.confirmed } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()

            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.selectionStyle = .none
            cell.alpha = 0.0

            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.deque(ActiveTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.active } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()

            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(DeathTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.death } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()

            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.deque(RecoveredTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.recovered } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()
        
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.deque(IncidentTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.incidentRate } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()

            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        else {
            let cell = tableView.deque(MortalityTableViewCell.self, for: indexPath)
            cell.labelNumber.text = "\(String(describing: covidList.map { $0.mortalityRate } ))"
            cell.labelNumber.text?.removeFirst()
            cell.labelNumber.text?.removeLast()

         
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
//        if indexPath.row == 7 {
//            let sb = UIStoryboard(name: "MapViewController", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//
//            vc.latitude  =  covidList.map { $0.latitude  }
//            vc.longitude =  covidList.map { $0.longitude }
//            viewModel.controller.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
