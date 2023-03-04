//
//  ViewController.swift
//  Test
//
//  Created by Anna on 04.03.2023.
//

import UIKit

class CitiesViewController: UIViewController {

    let dataService = DataManager()
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //citiesTableView.delegate = self
        citiesTableView.dataSource = self
        registerTableCells()
    }
    override func viewDidAppear(_ animated: Bool) {
        print("start \(Date())")
        dataService.fetchData { [weak self] result in
            switch result {
            case .success(_):
                self?.citiesTableView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func registerTableCells() {
        citiesTableView.register(UINib(nibName: CityTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataService.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            fatalError()
        }
        cell.nameLabel.text = "\(dataService.cities[indexPath.row].name), \(dataService.cities[indexPath.row].country)"
        return cell
    }
}
