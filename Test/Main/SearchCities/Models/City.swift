//
//  City.swift
//  Test
//
//  Created by Anna on 04.03.2023.
//

import Foundation

struct City: Decodable {
    let name: String
    let country: String
    let _id: Int
    let coord: Coordinates
}
struct Coordinates: Decodable {
    let lat: Float
    let lon: Float
}
