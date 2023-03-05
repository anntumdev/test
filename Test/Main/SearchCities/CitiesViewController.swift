//
//  ViewController.swift
//  Test
//
//  Created by Anna on 04.03.2023.
//

import UIKit

class CitiesViewController: UIViewController {
    
    let dataService = DataManager()
    
    var searchString: String?
    
    var filteredCities: [City] = []
    
    var sortWorkItem: DispatchWorkItem?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //citiesTableView.delegate = self
        citiesTableView.dataSource = self
        registerTableCells()
    }
    override func viewDidAppear(_ animated: Bool) {
        dataService.fetchData { [weak self] result in
            switch result {
            case .success(let cities):
                self?.filteredCities = cities
                self?.citiesTableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func sortCities() {
        if let searchString = searchString, searchString != "" {
            filteredCities = dataService.cities.filter{ city in city.name.lowercased().hasPrefix(searchString.lowercased())}
        } else {
            filteredCities = dataService.cities
        }
    }
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    private func registerTableCells() {
        citiesTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
    }
}
extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        let queue = DispatchQueue.global(qos: .userInitiated)
        sortWorkItem?.cancel()
        sortWorkItem = DispatchWorkItem() {
            self.sortCities()
        }
        guard let sortWorkItem = sortWorkItem else {return}
        queue.async(execute: sortWorkItem)
        sortWorkItem.notify(queue: .main) {
            self.citiesTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            fatalError()
        }
        cell.coordLabel.text = String(format: "Coordinates lat %.2f, lon %.2f", filteredCities[indexPath.row].coord.lat, filteredCities[indexPath.row].coord.lon)
        cell.nameLabel.text = "\(filteredCities[indexPath.row].name), \(filteredCities[indexPath.row].country)"
        return cell
    }
}
