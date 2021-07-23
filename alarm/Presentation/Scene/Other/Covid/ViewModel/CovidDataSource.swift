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
    
    var coordinator : CoordinatorProtocol?
    
    init(with tableView: UITableView, viewModel: CovidListViewModelProtocol) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.viewModel = viewModel
    }
    
    func refresh() {
//        viewModel.getCountriesList { countries in
//            self.citiesList.append(contentsOf: countries)
//            self.filteredCitiesList.append(contentsOf: countries)
//            self.tableView.reloadData()
//        }
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

            return cell        }
        
        if indexPath.row == 1 {
            let cell = tableView.deque(CovidConfirmedTableViewCell.self, for: indexPath)
            cell.textLabel?.text = "Confirmed:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.selectionStyle = .none
            cell.alpha = 0.0

            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.deque(ActiveTableViewCell.self, for: indexPath)
            cell.textLabel?.text = "Active:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.deque(DeathTableViewCell.self, for: indexPath)
            cell.textLabel?.text = "Death:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.deque(RecoveredTableViewCell.self, for: indexPath)
            cell.textLabel?.text = "Recovered:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.deque(IncidentTableViewCell.self, for: indexPath)
            cell.textLabel?.text = "Incident Rate:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
        else {
            let cell = tableView.deque(MortalityTableViewCell.self, for: indexPath)
            cell.textLabel?.text = "Mortality Rate:"
            cell.detailTextLabel?.text = "2"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
            cell.alpha = 0.0
            cell.selectionStyle = .none

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { return 200}
        else                  { return 90 }
    }
}



extension CovidDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.controller.coordinator?.didTapOnCell()
    
       
        print(indexPath.row)
    }
}
