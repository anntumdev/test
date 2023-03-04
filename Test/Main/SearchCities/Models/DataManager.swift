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
                DispatchQueue.main.async {
                    let array = Array(cities.prefix(100).sorted{$0.name < $1.name})
                    self.cities = array
                    completion(.success(array))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
