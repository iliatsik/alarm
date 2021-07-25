//
//  CountriesDataSource.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 12.06.21.
//

import UIKit

class CountriesDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Private properties
    
    private var tableView: UITableView!
    private var viewModel: CountriesListViewModelProtocol!
    
    private var filteredCitiesList = [CountryViewModel]()
    private var citiesList = [CountryViewModel]()
    
    var coordinator  : CoordinatorProtocol?
    
    init(with tableView: UITableView, viewModel: CountriesListViewModelProtocol) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel = viewModel
    }
    
    func refresh() {
        viewModel.getCountriesList { countries in
            self.citiesList.append(contentsOf: countries)
            self.filteredCitiesList.append(contentsOf: countries)
            self.tableView.reloadData()
        }
    }
    
    func search(with text: String) {
        filteredCitiesList.removeAll()
        
        for country in citiesList {
            if country.capital.lowercased().contains(text.lowercased()) {
                filteredCitiesList.append(country)
            }
        
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCitiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(CountryTableViewCell.self, for: indexPath)
        cell.configure(with: filteredCitiesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}



extension CountriesDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.controller.coordinator?.didTapOnCell()
        
        viewModel.controller.coordinator?.passCountry(countryName: filteredCitiesList[indexPath.row].name)
        
        viewModel.getWeatherData(with: "Germany") { [weak self] result in
//            print(result)
        }
        
        print(indexPath.row)
    }
}
