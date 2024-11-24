//
//  City.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import Foundation

struct City: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
}
