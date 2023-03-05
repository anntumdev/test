//
//  DataManager.swift
//  Test
//
//  Created by Anna on 04.03.2023.
//

import Foundation

class DataManager {
    
    var cities: [City] = []
    
    func fetchData(completion: @escaping (Result<[City], Error>) -> Void) {
        DispatchQueue.global(qos:.userInteractive).async {
            guard let path = Bundle.main.path(forResource: "cities", ofType: "json") else {
                return
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let cities = try decoder.decode([City].self, from: data)
                let sortesCities = cities.sorted(by: {($0.name.lowercased(), $0.country.lowercased()) < ($1.name.lowercased(), $1.country.lowercased())})
                DispatchQueue.main.async {
                    self.cities = sortesCities
                    completion(.success(sortesCities))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
